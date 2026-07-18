#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_DIRECTORY="$(
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
  pwd -P
)"
readonly REPOSITORY_ROOT="$SCRIPT_DIRECTORY"
readonly HOSTS_DIRECTORY="${REPOSITORY_ROOT}/hosts"
readonly TEMPLATE_DIRECTORY="${HOSTS_DIRECTORY}/example"
readonly TOTAL_STEPS=8

hostName=""
timeZone=""
hostDirectory=""
hostRelativeDirectory=""
hostEnvironment=""

hostCreated=false
hostStaged=false
installationSucceeded=false

print_separator() {
  printf '%s\n' \
    '----------------------------------------------------------------'
}

print_step() {
  local stepNumber=$1
  local message=$2

  printf '\n[%s/%s] %s\n' \
    "$stepNumber" "$TOTAL_STEPS" "$message"
  print_separator
}

rollback_generated_host() {
  local cleanupStatus="complete"

  if [[ "$hostStaged" == true && -n "$hostRelativeDirectory" ]]; then
    if git -C "$REPOSITORY_ROOT" reset -q -- "$hostRelativeDirectory"; then
      hostStaged=false
      printf 'Removed Git staging for: %s\n' \
        "$hostRelativeDirectory" >&2
    else
      printf 'Warning: failed to unstage: %s\n' \
        "$hostRelativeDirectory" >&2
      cleanupStatus="incomplete"
    fi
  fi

  if [[ "$hostCreated" == true && -n "$hostDirectory" ]]; then
    if rm -rf -- "$hostDirectory"; then
      hostCreated=false
      printf 'Removed generated host directory: %s\n' \
        "$hostDirectory" >&2
    else
      printf 'Warning: failed to remove: %s\n' \
        "$hostDirectory" >&2
      cleanupStatus="incomplete"
    fi
  fi

  printf '%s' "$cleanupStatus"
}

print_recovery_steps() {
  local cleanupStatus=$1
  local rollbackAttempted=$2

  printf '\nRecovery information\n' >&2
  print_separator >&2

  if [[ "$rollbackAttempted" != true ]]; then
    printf '%s\n' \
      'No host files were created, so no rollback was required.' >&2
    printf '%s\n' 'Review the error above, then retry with:' >&2
    printf '  %q\n' "${REPOSITORY_ROOT}/install.sh" >&2
    return
  fi

  if [[ "$cleanupStatus" == "complete" ]]; then
    printf '%s\n' \
      'The generated host directory and its Git staging state were removed.' >&2
    printf '%s\n' 'Review the error above, then retry with:' >&2
    printf '  %q\n' "${REPOSITORY_ROOT}/install.sh" >&2
    return
  fi

  printf '%s\n' \
    'Automatic cleanup was incomplete.' >&2
  printf '%s\n' \
    'Review the remaining files and Git state before retrying.' >&2

  if [[ -n "$hostRelativeDirectory" ]]; then
    printf '\nInspect the remaining state:\n' >&2
    printf '  git -C %q status --short -- %q\n' \
      "$REPOSITORY_ROOT" \
      "$hostRelativeDirectory" >&2

    printf '  git -C %q diff --cached -- %q\n' \
      "$REPOSITORY_ROOT" \
      "$hostRelativeDirectory" >&2
  fi

  if [[ -n "$hostDirectory" ]]; then
    printf '\nRemove the generated host manually:\n' >&2
    printf '  git -C %q reset -q -- %q\n' \
      "$REPOSITORY_ROOT" \
      "$hostRelativeDirectory" >&2

    printf '  rm -rf -- %q\n' \
      "$hostDirectory" >&2
  fi
}

on_error() {
  local exitCode=$?
  local lineNumber=$1
  local cleanupStatus="complete"
  local rollbackAttempted=false

  trap - ERR INT TERM

  printf '\nInstallation failed at line %s with exit code %s.\n' \
    "$lineNumber" "$exitCode" >&2

  if [[ "$installationSucceeded" != true && "$hostCreated" == true ]]; then
    rollbackAttempted=true

    printf '%s\n' \
      'Rolling back the generated host configuration and Git staging state.' >&2

    cleanupStatus="$(rollback_generated_host)"
  fi

  print_recovery_steps \
    "$cleanupStatus" \
    "$rollbackAttempted"

  exit "$exitCode"
}

on_signal() {
  local signalName=$1
  local cleanupStatus="complete"
  local rollbackAttempted=false

  trap - ERR INT TERM

  printf '\nInstallation interrupted by %s.\n' \
    "$signalName" >&2

  if [[ "$installationSucceeded" != true && "$hostCreated" == true ]]; then
    rollbackAttempted=true

    printf '%s\n' \
      'Rolling back the generated host configuration and Git staging state.' >&2

    cleanupStatus="$(rollback_generated_host)"
  fi

  print_recovery_steps \
    "$cleanupStatus" \
    "$rollbackAttempted"

  exit 130
}

trap 'on_error "$LINENO"' ERR
trap 'on_signal INT' INT
trap 'on_signal TERM' TERM

# Always operate from the repository containing this script.
cd -- "$REPOSITORY_ROOT"

print_step 1 'Checking the installation environment'

requiredCommands=(
  git
  grep
  id
  nix
  nixos-generate-config
  nixos-rebuild
  sed
  sudo
  timedatectl
)

for commandName in "${requiredCommands[@]}"; do
  if ! command -v "$commandName" >/dev/null 2>&1; then
    printf 'Required command is not available: %s\n' \
      "$commandName" >&2
    exit 1
  fi
done

if [[ ! -f "${REPOSITORY_ROOT}/flake.nix" ]]; then
  printf 'flake.nix was not found in the repository root: %s\n' \
    "$REPOSITORY_ROOT" >&2
  exit 1
fi

if ! git -C "$REPOSITORY_ROOT" \
  rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'The repository root is not inside a Git work tree: %s\n' \
    "$REPOSITORY_ROOT" >&2
  exit 1
fi

if grep -qEi '^ID="?nixos"?$' /etc/os-release; then
  printf '%s\n' 'Currently running NixOS.'
else
  printf '%s\n' \
    'Please run this installer on NixOS.' >&2
  exit 1
fi

if [[ -e /run/current-system ]]; then
  printf '%s\n' \
    'Detected an installed NixOS system.'
else
  printf '%s\n' \
    'Please run this installer on an installed NixOS system, not a LiveCD.' >&2
  exit 1
fi

if [[ ${EUID} -eq 0 ]]; then
  printf '%s\n' \
    'Please run this installer as a normal user rather than root.' >&2
  exit 1
fi

print_step 2 'Detecting host defaults'

readonly userName="$(id -un)"

detectedTimeZone="$(
  timedatectl show \
    --property=Timezone \
    --value
)"

if [[ -z "$detectedTimeZone" || "$detectedTimeZone" == "n/a" ]]; then
  printf '%s\n' \
    'Unable to detect the current system time zone.' >&2
  exit 1
fi

printf 'Repository root:    %s\n' "$REPOSITORY_ROOT"
printf 'Primary username:   %s\n' "$userName"
printf 'Detected time zone: %s\n' "$detectedTimeZone"

print_step 3 'Validating the host template'

if [[ ! -d "$TEMPLATE_DIRECTORY" ]]; then
  printf 'Host template does not exist: %s\n' \
    "$TEMPLATE_DIRECTORY" >&2
  exit 1
fi

if [[ ! -f "${TEMPLATE_DIRECTORY}/default.nix" ]]; then
  printf 'Host template is missing default.nix: %s\n' \
    "$TEMPLATE_DIRECTORY" >&2
  exit 1
fi

if [[ ! -f "${TEMPLATE_DIRECTORY}/env.nix" ]]; then
  printf 'Host template is missing env.nix: %s\n' \
    "$TEMPLATE_DIRECTORY" >&2
  exit 1
fi

if ! grep -Eq \
  '^[[:space:]]*Username[[:space:]]*=' \
  "${TEMPLATE_DIRECTORY}/env.nix"; then
  printf 'Username is not declared in template: %s\n' \
    "${TEMPLATE_DIRECTORY}/env.nix" >&2
  printf '%s\n' \
    'Expected format: Username = "admin";' >&2
  exit 1
fi

if ! grep -Eq \
  '^[[:space:]]*TimeZone[[:space:]]*=' \
  "${TEMPLATE_DIRECTORY}/env.nix"; then
  printf 'TimeZone is not declared in template: %s\n' \
    "${TEMPLATE_DIRECTORY}/env.nix" >&2
  printf '%s\n' \
    'Expected format: TimeZone = "Asia/Tokyo";' >&2
  exit 1
fi

printf '%s\n' \
  'The host template contains all required files and attributes.'

print_step 4 'Collecting host settings'

printf '%s\n' \
  'Default options are shown in brackets.'
printf '%s\n' \
  'Press Enter to accept a default value.'

read -r -p 'Enter hostname [nixos]: ' hostName
hostName="${hostName:-nixos}"

read -r -p "Enter time zone [${detectedTimeZone}]: " timeZone
timeZone="${timeZone:-$detectedTimeZone}"

# Linux hostnames should use lowercase letters, digits, and internal hyphens.
if [[ ! "$hostName" =~ ^[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?$ ]]; then
  printf '%s\n' \
    'Invalid hostname. Use lowercase letters, digits, and internal hyphens.' >&2
  exit 1
fi

# Avoid grep -q because pipefail may treat timedatectl receiving SIGPIPE
# as a pipeline failure after grep finds a matching line.
if ! timedatectl list-timezones |
  grep -Fx -- "$timeZone" >/dev/null; then
  printf 'Invalid time zone: %s\n' \
    "$timeZone" >&2
  printf '%s\n' \
    'Run "timedatectl list-timezones" to list valid time zones.' >&2
  exit 1
fi

hostRelativeDirectory="hosts/${hostName}"
hostDirectory="${REPOSITORY_ROOT}/${hostRelativeDirectory}"
hostEnvironment="${hostDirectory}/env.nix"

if [[ -e "$hostDirectory" ]]; then
  printf 'Host configuration already exists: %s\n' \
    "$hostDirectory" >&2
  printf '%s\n' \
    'The existing directory was not modified.' >&2
  exit 1
fi

print_step 5 'Reviewing the installation plan'

printf 'Hostname:          %s\n' "$hostName"
printf 'Primary username:  %s\n' "$userName"
printf 'Time zone:         %s\n' "$timeZone"
printf 'Template:          %s\n' "$TEMPLATE_DIRECTORY"
printf 'Destination:       %s\n' "$hostDirectory"
printf 'Flake target:      .#%s\n' "$hostName"
printf '%s\n' \
  'System action:     nixos-rebuild switch'
printf 'Git action:        stage only %s\n' \
  "$hostRelativeDirectory"

print_separator

read -r -p 'Continue with this installation? [Y/n]: ' confirmation
confirmation="${confirmation:-Y}"

case "$confirmation" in
  Y | y | yes | YES | Yes)
    ;;
  *)
    printf '%s\n' \
      'Installation cancelled. No files were created.'
    exit 0
    ;;
esac

print_step 6 'Creating and validating the host configuration'

mkdir -- "$hostDirectory"
hostCreated=true

cp -a \
  "${TEMPLATE_DIRECTORY}/." \
  "$hostDirectory/"

# Set the primary username in the new host environment.
sed -i -E \
  "s|^([[:space:]]*Username[[:space:]]*=[[:space:]]*)\"[^\"]*\";|\1\"${userName}\";|" \
  "$hostEnvironment"

# Set the time zone in the new host environment.
sed -i -E \
  "s|^([[:space:]]*TimeZone[[:space:]]*=[[:space:]]*)\"[^\"]*\";|\1\"${timeZone}\";|" \
  "$hostEnvironment"

if ! grep -Eq \
  "^[[:space:]]*Username[[:space:]]*=[[:space:]]*\"${userName}\";" \
  "$hostEnvironment"; then
  printf 'Failed to set Username in: %s\n' \
    "$hostEnvironment" >&2

  # Trigger ERR so the rollback handler runs.
  false
fi

if ! grep -Eq \
  "^[[:space:]]*TimeZone[[:space:]]*=[[:space:]]*\"${timeZone}\";" \
  "$hostEnvironment"; then
  printf 'Failed to set TimeZone in: %s\n' \
    "$hostEnvironment" >&2

  # Trigger ERR so the rollback handler runs.
  false
fi

printf '%s\n' \
  'Generating hardware configuration.'

nixos-generate-config \
  --show-hardware-config \
  >"${hostDirectory}/hardware.nix"

printf '%s\n' \
  'Staging the generated host for Git-backed flake evaluation.'

git -C "$REPOSITORY_ROOT" \
  add -- "$hostRelativeDirectory"

hostStaged=true

printf '%s\n' \
  'Evaluating hostname, username, and time zone.'

evaluatedHostName="$(
  nix eval \
    --extra-experimental-features 'nix-command flakes' \
    --raw \
    ".#nixosConfigurations.${hostName}.config.networking.hostName"
)"

if [[ "$evaluatedHostName" != "$hostName" ]]; then
  printf 'Hostname verification failed: expected "%s", received "%s".\n' \
    "$hostName" "$evaluatedHostName" >&2

  false
fi

evaluatedUserName="$(
  nix eval \
    --extra-experimental-features 'nix-command flakes' \
    --raw \
    ".#nixosConfigurations.${hostName}.config.home-manager.users.${userName}.home.username"
)"

if [[ "$evaluatedUserName" != "$userName" ]]; then
  printf 'Username verification failed: expected "%s", received "%s".\n' \
    "$userName" "$evaluatedUserName" >&2

  false
fi

evaluatedTimeZone="$(
  nix eval \
    --extra-experimental-features 'nix-command flakes' \
    --raw \
    ".#nixosConfigurations.${hostName}.config.time.timeZone"
)"

if [[ "$evaluatedTimeZone" != "$timeZone" ]]; then
  printf 'Time zone verification failed: expected "%s", received "%s".\n' \
    "$timeZone" "$evaluatedTimeZone" >&2

  false
fi

printf 'Verified hostname:  %s\n' "$evaluatedHostName"
printf 'Verified username:  %s\n' "$evaluatedUserName"
printf 'Verified time zone: %s\n' "$evaluatedTimeZone"

print_step 7 'Rebuilding and switching the system'

printf '%s\n' \
  'The configuration passed evaluation.'
printf '%s\n' \
  'Stay online and do not power down during the system rebuild.'

sudo nixos-rebuild switch \
  --flake ".#${hostName}" \
  --show-trace \
  -L

# Do not roll back the generated source after the system has switched.
installationSucceeded=true

print_step 8 'Performing post-installation cleanup'

cleanupWarning=false

# Channel cleanup is non-critical. A failure here must not turn a successful
# system rebuild into an installation failure.
if ! sudo rm -rf \
  /nix/var/nix/profiles/per-user/root/channels \
  /root/.nix-defexpr/channels; then
  cleanupWarning=true

  printf '%s\n' \
    'Warning: the system rebuild succeeded, but obsolete nix-channel files could not be removed.' >&2
  printf '%s\n' \
    'You can retry the cleanup manually with:' >&2
  printf '%s\n' \
    '  sudo rm -rf /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels' >&2
fi

print_separator
printf '%s\n' \
  'Installation completed successfully.'
printf 'Active host configuration: .#%s\n' \
  "$hostName"
printf 'Generated host directory:  %s\n' \
  "$hostDirectory"

printf '%s\n' \
  'The generated host configuration remains staged in Git.'
printf '%s\n' \
  'Review the staged configuration with:'
printf '  git -C %q diff --cached -- %q\n' \
  "$REPOSITORY_ROOT" \
  "$hostRelativeDirectory"

if [[ "$cleanupWarning" == true ]]; then
  printf '%s\n' \
    'The installation completed with a non-fatal cleanup warning.'
fi

printf '%s\n' \
  'Please reboot to get a brand new system.'
printf '%s\n' \
  'Live long and prosper!'
