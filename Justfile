# Set current hostname
hostname := `hostname`

# Set current username
username := `whoami`


anywhere input:
  # Perform nixos-anywhere install
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}}


anywhere-lb input:
  # Perform nixos-anywhere install (local builder)
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}} --build-on local


anywhere-vm input:
  # Test nixos-anywhere install in vm
  nix run github:nix-community/nixos-anywhere -- --flake .#{{input}} --vm-test


build input:
  # Build
  sudo nixos-rebuild build --flake .#{{input}} --show-trace -L -v


build-vm input:
  # Build a vm
  sudo nixos-rebuild build-vm --flake .#{{input}} --show-trace -L -v


clean:
  # Remove useless nix-channel files
  sudo rm -rf /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels


format:
  # Use alejandra and deadnix to format code
  deadnix -e
  alejandra .


gc:
  # Do garbage-clean (remove unused packages, etc)
  sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system
  sudo nix-collect-garbage --delete-old


ghc:
  # Generate hardware.nix
  nixos-generate-config --show-hardware-config > ./hosts/{{hostname}}/hardware.nix


install:
  # Install this flake
  bash install.sh


list:
  # List system packages
  nix-store -qR /run/current-system | cat


profile:
  # Show system profile
  sudo nix profile history --profile /nix/var/nix/profiles/system


switch input:
  # Let system rebuild and switch
  sudo nixos-rebuild switch --flake .#{{input}} --show-trace -L -v


update:
  # Update flake.lock
  nix flake update --extra-experimental-features flakes --extra-experimental-features nix-command --show-trace


upgrade:
  # Let system totally upgrade
  ## Set hostname and username in flake.nix
  sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{hostname}}\"/" ./flake.nix
  sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{username}}\"/" ./flake.nix
  git add .
  ## Rebuild the system
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace


upgrade-debug:
  # Let system totally upgrade (deBug Mode)
  ## Set hostname and username in flake.nix
  sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{hostname}}\"/" ./flake.nix
  sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{username}}\"/" ./flake.nix
  git add .
  ## Rebuild the system
  sudo unbuffer nixos-rebuild switch --flake .#{{hostname}} --sudo --log-format internal-json --show-trace -L -v |& nom --json
