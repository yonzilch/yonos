#!/usr/bin/env bash

set -Eeuo pipefail

readonly HOSTS_DIRECTORY="./hosts"
readonly TEMPLATE_DIRECTORY="${HOSTS_DIRECTORY}/example"

on_error() {
  local exit_code=$?
  local line_number=$1

  printf 'Installation failed at line %s with exit code %s.\n' \
    "$line_number" "$exit_code" >&2

  exit "$exit_code"
}

trap 'on_error "$LINENO"' ERR

print_separator() {
  printf '%s\n' \
    '----------------------------------------------------------------'
}

# Check whether the current system is NixOS.
if grep -qEi '^ID="?nixos"?$' /etc/os-release; then
  printf '%s\n' 'Currently running NixOS, continuing.'
  print_separator
else
  printf '%s\n' 'Please run this installer on NixOS.' >&2
  exit 1
fi

# Check whether this is an installed NixOS system.
if [[ -e /run/current-system ]]; then
  printf '%s\n' 'Running on an installed NixOS system, continuing.'
  print_separator
else
  printf '%s\n' \
    'Please run this installer on an installed NixOS system, not a LiveCD.' >&2
  exit 1
fi

# Require a normal user because it becomes the primary host user.
if [[ ${EUID} -eq 0 ]]; then
  printf '%s\n' \
    'Please run this installer as a normal user rather than root.' >&2
  exit 1
fi

readonly userName="$(id -un)"

printf 'Primary username: %s\n' "$userName"
print_separator

# Validate the host template before creating a new configuration.
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

printf '%s\n' 'Default options are shown in brackets.'
printf '%s\n' 'Press Enter to accept the default.'
print_separator

read -r -p 'Enter hostname ' hostName
hostName="${hostName:-nixos}"

# Linux hostnames should use lowercase letters, digits, and hyphens.
if [a-z0-9-]{0,61}[a-z0-9]?$ ]]; then
  printf '%s\n' \
    'Invalid hostname. Use lowercase letters, digits, and internal hyphens.' >&2
  exit 1
fi

readonly hostDirectory="${HOSTS_DIRECTORY}/${hostName}"
readonly hostEnvironment="${hostDirectory}/env.nix"

# Do not overwrite an existing host configuration.
if [[ -e "$hostDirectory" ]]; then
  printf 'Host configuration already exists: %s\n' \
    "$hostDirectory" >&2
  exit 1
fi

printf 'Creating host configuration: %s\n' "$hostName"
printf 'Configuring primary user: %s\n' "$userName"
print_separator

mkdir -- "$hostDirectory"
cp -a "${TEMPLATE_DIRECTORY}/." "$hostDirectory/"

# Ensure that the host template declares Username.
if ! grep -Eq \
  '^[[:space:]]*Username[[:space:]]*=' \
  "$hostEnvironment"; then
  printf 'Username is not declared in template: %s\n' \
    "$hostEnvironment" >&2
  exit 1
fi

# Set the primary username in the new host environment.
sed -i -E \
  "s|^([[:space:]]*Username[[:space:]]*=[[:space:]]*)\"[^\"]*\";|\1\"${userName}\";|" \
  "$hostEnvironment"

# Verify that the username replacement succeeded.
if ! grep -Eq \
  "^[[:space:]]*Username[[:space:]]*=[[:space:]]*\"${userName}\";" \
  "$hostEnvironment"; then
  printf 'Failed to set Username in: %s\n' \
    "$hostEnvironment" >&2
  exit 1
fi

# Generate the host-specific hardware configuration.
nixos-generate-config \
  --show-hardware-config \
  > "${hostDirectory}/hardware.nix"

# A Git-backed flake cannot see untracked host files.
git add -- "$hostDirectory"

# Verify that the dynamically generated configuration exists.
evaluatedHostName="$(
  nix eval \
    --extra-experimental-features 'nix-command flakes' \
    --raw \
    ".#nixosConfigurations.${hostName}.config.networking.hostName"
)"

if [[ "$evaluatedHostName" != "$hostName" ]]; then
  printf 'Hostname verification failed: expected "%s", received "%s".\n' \
    "$hostName" "$evaluatedHostName" >&2
  exit 1
fi

# Verify that Home Manager receives the username from env.nix.
evaluatedUserName="$(
  nix eval \
    --extra-experimental-features 'nix-command flakes' \
    --raw \
    ".#nixosConfigurations.${hostName}.config.home-manager.users.${userName}.home.username"
)"

if [[ "$evaluatedUserName" != "$userName" ]]; then
  printf 'Username verification failed: expected "%s", received "%s".\n' \
    "$userName" "$evaluatedUserName" >&2
  exit 1
fi

printf 'Verified hostname: %s\n' "$evaluatedHostName"
printf 'Verified username: %s\n' "$evaluatedUserName"
printf '%s\n' \
  'The configuration passed evaluation and is ready to build.'
printf '%s\n' \
  'Stay online and do not power down during the system rebuild.'
print_separator

sleep 2

sudo nixos-rebuild switch \
  --flake ".#${hostName}" \
  --show-trace \
  -L

print_separator

# Remove obsolete nix-channel files.
sudo rm -rf \
  /nix/var/nix/profiles/per-user/root/channels \
  /root/.nix-defexpr/channels

print_separator
printf '%s\n' 'Installation completed.'
printf '%s\n' 'Live long and prosper!'
printf '%s\n' 'Please reboot to get a brand new system.'
printf '%s\n' \
  'If anything goes wrong, please include the rebuild log in the report.'
