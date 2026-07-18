@default:
  @just --list

# Set current hostname
hostname := `hostname`

@anywhere input:
  # Perform nixos-anywhere install
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}}

@anywhere-lb input:
  # Perform nixos-anywhere install with a local builder
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}} --build-on local

@anywhere-vm input:
  # Test nixos-anywhere install in a VM
  nix run github:nix-community/nixos-anywhere -- --flake .#{{input}} --vm-test

@build input:
  # Build the selected host
  sudo nixos-rebuild build --flake .#{{input}} --show-trace -L -v

@build-vm input:
  # Build a VM for the selected host
  sudo nixos-rebuild build-vm --flake .#{{input}} --show-trace -L -v

@clean:
  # Remove obsolete nix-channel files
  sudo rm -rf /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels

@fix:
  # Verify and repair the Nix store
  sudo nix-store --verify --check-contents --repair

@format:
  # Format Nix code and detect unused expressions
  deadnix -e
  find . -type f -name '*.nix' -exec nixfmt {} +

@gc:
  # Remove old system profiles and unused store paths
  sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system
  sudo nix-collect-garbage --delete-old

@ghc:
  # Generate hardware configuration for the current host
  nixos-generate-config --show-hardware-config > ./hosts/{{hostname}}/hardware.nix

@install:
  # Install this flake
  bash install.sh

@list:
  # List packages in the current system closure
  nix-store -qR /run/current-system | cat

@profile:
  # Show the system profile history
  sudo nix profile history --profile /nix/var/nix/profiles/system

@profile-diff:
  # Show differences between system profile generations
  sudo nix profile diff-closures --profile /nix/var/nix/profiles/system

@switch input:
  # Rebuild and switch to the selected host configuration
  sudo nixos-rebuild switch --flake .#{{input}} --show-trace -L -v

@update:
  # Update flake.lock
  nix flake update --extra-experimental-features flakes --extra-experimental-features nix-command --show-trace

@upgrade:
  # Verify and switch to the configuration matching the current hostname
  nix eval --raw .#nixosConfigurations.{{hostname}}.config.networking.hostName
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace

@upgrade-debug:
  # Verify and switch to the current host configuration in debug mode
  nix eval --raw .#nixosConfigurations.{{hostname}}.config.networking.hostName
  sudo unbuffer nixos-rebuild switch --flake .#{{hostname}} --sudo --log-format internal-json --show-trace -L -v |& nom --json
