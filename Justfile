# set hostname environment
hostname := `hostname`

# set current username
username := `whoami`


anywhere input:
  # perform nixos-anywhere install
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}}


anywhere-lb input:
  # perform nixos-anywhere install (local builder)
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}} --build-on local


anywhere-vm input:
  # test nixos-anywhere install in local vm
  nix run github:nix-community/nixos-anywhere -- --flake .#{{input}} --vm-test


build input:
  # build
  sudo nixos-rebuild build --flake .#{{input}} --show-trace -L -v


build-vm input:
  # build a vm
  sudo nixos-rebuild build-vm --flake .#{{input}} --show-trace -L -v


clean:
  # remove useless nix-channel files
  sudo rm -rf /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels


format:
  # use alejandra and deadnix format code
  deadnix -e
  alejandra .


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
  ## Update both hostname and username in flake.nix
  sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{hostname}}\"/" ./flake.nix
  sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{username}}\"/" ./flake.nix
  git add .
  ## Rebuild the system
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace


upgrade-debug:
  # let system totally upgrade (deBug Mode)
  ## Update both hostname and username in flake.nix
  sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{hostname}}\"/" ./flake.nix
  sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"{{username}}\"/" ./flake.nix
  git add .
  ## Rebuild the system
  sudo unbuffer nixos-rebuild switch --flake .#{{hostname}} --sudo --log-format internal-json --show-trace -L -v |& nom --json
