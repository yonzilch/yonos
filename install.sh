#!/usr/bin/env bash

# Check if running on NixOS
if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "Current running NixOS, going next step"
    echo "--------------------------------"
else
    echo "Please install under NixOS host"
    exit
fi

# Check if boot directory exists to detect NixOS LiveCD environment
if [ -d "/boot" ]; then
    echo "Running on installed NixOS, going next step"
    echo "--------------------------------"
else
    echo "Please install under installed NixOS not LiveCD"
    exit 1
fi

# Get username
if [ "$(whoami)" == "root" ]; then
    echo "Please install as a normal user rather than root"
    exit 1
else
    echo "Successfully get the username, going next step"
    echo "--------------------------------"
fi

echo "Default options are in brackets [ ]"
echo "Just press enter as default"
echo "--------------------------------"
sleep 2

read -p "Enter Hostname: [ nixos ] " hostName
if [ -z "$hostName" ]; then
  hostName="nixos"
fi

mkdir hosts/"$hostName"
cp hosts/example/*.nix hosts/"$hostName"
sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix

userName=$(whoami)
sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$userName\"/" ./flake.nix

nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware.nix

git add .

echo "Now going to build, stay online and don't power down."
echo "--------------------------------"
sleep 2

NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#${hostName} --sudo

echo "--------------------------------"

echo "Jobs done."
echo "Live long and prosper!"
echo "Please reboot to get a brand new system"
