# set hostname environment
hostname := `hostname`

build-image:
  # build system image
  sudo nix build .#image --impure --show-trace -L -v --extra-experimental-features flakes --extra-experimental-features nix-command


build input:
  # build
  sudo nixos-rebuild build --flake .#{{input}} --show-trace -L -v


build-vm input:
  # build a vm
  sudo nixos-rebuild build-vm --flake .#{{input}} --show-trace -L -v


clean-channels:
  # remove nix-channel files
  sudo rm -rf /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels


gc:
  # let system gc (remove unused packages, etc)
  sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system
  sudo nix-collect-garbage --delete-old


ghc:
  # generate hardware.nix
  nixos-generate-config --show-hardware-config > ./hosts/{{hostname}}/hardware.nix


install:
  # install this flake
  bash install.sh


list:
  # list system packages
  nix-store -qR /run/current-system | cat


profile:
  # show system profile
  sudo nix profile history --profile /nix/var/nix/profiles/system


switch input:
  # let system rebuild and switch
  sudo nixos-rebuild switch --flake .#{{input}} --show-trace -L -v


update:
  # let flake update
  sudo nix flake update --extra-experimental-features flakes --extra-experimental-features nix-command


upgrade:
  # let system totally upgrade
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace --sudo


upgrade-debug:
  # let system totally upgrade (deBug Mode)
  sudo unbuffer nixos-rebuild switch --flake .#{{hostname}} --log-format internal-json --show-trace -L -v |& nom --json --sudo
