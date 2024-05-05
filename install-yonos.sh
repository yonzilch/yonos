#!/usr/bin/env bash

if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "Verified this is NixOS."
    echo "-----"
else
    echo "This is not NixOS or the distribution information is not available."
    exit
fi

if command -v git &> /dev/null; then
    echo "Git is installed, continuing with installation."
else
    echo "Git is not installed. Please install Git and try again."
    echo "Example: nix-shell -p git"
    exit 1
fi

echo "-----"

echo "Ensure In Home Directory"
cd

echo "-----"

# Check For Persistence. Backing up current flake files
# with it enabled is not yet implemented.
persistState=$(cat yonos/hardware.nix | grep persistence | wc -l)
if [ $persistState -eq 0 ]; then
  backupname=$(date "+%Y-%m-%d-%H-%M-%S")
  if [ -d "yonos" ]; then
    echo "YonOS exists, backing up to .config/yonos-backups folder."
    if [ -d ".config/yonos-backups" ]; then
      echo "Moving current version of YonOS to backups folder."
      mv $HOME/yonos .config/yonos-backups/$backupname
      sleep 1
    else
      echo "Creating the backups folder & moving YonOS to it."
      mkdir -p .config/yonos-backups
      mv $HOME/yonos .config/yonos-backups/$backupname
      sleep 1
    fi
  else
    echo "Thank you for choosing YonOS."
    echo "I hope you find your time here enjoyable!"
  fi
fi

echo "-----"

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

echo "Cloning & Entering YonOS Repository"
git clone https://github.com/yonzilch/yonos.git
cd yonos

echo "-----"

installusername=$(echo $USER)
read -p "Enter Your Username: [ $installusername ] " userName
if [ -z "$userName" ]; then
  userName=$(echo $USER)
else
  if [ $installusername != $userName ]; then
    echo "This will create a hashedPassword for the new user in the options file."
    while true; do
      read -s -p "Enter New User Password: " newPass
      read -s -p "Enter New User Password Again: " newPass2
      if [ $newPass == $newPass2 ]; then
	echo "Passwords Match. Setting password."
	userPassword=$(mkpasswd -m sha-512 $newPass)
	escaped_userPassword=$(echo "$userPassword" | sed 's/\//\\\//g')
	sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_userPassword\"#" ./system.nix
	break
      fi
    done
  fi
fi
sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$userName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Hostname: [ yonos ] " hostName
if [ -z "$hostName" ]; then
  hostName="yonos"
fi
sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Git Username: [ John Smith ] " gitUserName
if [ -z "$gitUserName" ]; then
  gitUserName="John Smith"
fi
sed -i "/^\s*gitUsername[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitUserName\"/" ./options.nix

echo "-----"

read -p "Enter Your New Git Email: [ johnsmith@example.com ] " gitEmail
if [ -z "$gitEmail" ]; then
  gitEmail="johnsmith@example.com"
fi
sed -i "/^\s*gitEmail[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitEmail\"/" ./options.nix

echo "-----"

read -p "Enter Your Locale: [ en_US.UTF-8 ] " locale
if [ -z "$locale" ]; then
  locale="en_US.UTF-8"
fi
sed -i "/^\s*theLocale[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$locale\"/" ./options.nix

echo "-----"

read -p "Enter Your Timezone: [ Asia/Shanghai ] " timezone
if [ -z "$timezone" ]; then
  timezone="Asia/Shanghai"
fi
escaped_timezone=$(echo "$timezone" | sed 's/\//\\\//g')
sed -i "/^\s*theTimezone[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_timezone\"#" ./options.nix

echo "-----"

read -p "Enable Animated Borders: [ false ] " animBorder
user_input_lower=$(echo "$animBorder" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  y|yes|true|t|enable)
    animBorder="true"
    ;;
  *)
    animBorder="false"
    ;;
esac
sed -i "/^\s*borderAnim[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$animBorder\"/" ./options.nix

echo "-----"

echo "Valid options include amd, intel, and vm"
read -p "Enter Your CPU Type: [ amd ] " cpuType
user_input_lower=$(echo "$cpuType" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  amd)
    cpuType="amd"
    ;;
  intel)
    cpuType="intel"
    ;;
  vm)
    cpuType="vm"
    ;;
  *)
    echo "Option Entered Not Available, Falling Back To [ amd ] Option."
    sleep 1
    cpuType="amd"
    ;;
esac
sed -i "/^\s*cpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$cpuType\"/" ./options.nix

echo "-----"

echo "Valid options include amd, intel, nvidia, vm, intel-nvidia"
read -p "Enter Your GPU Type : " gpuType
user_input_lower=$(echo "$gpuType" | tr '[:upper:]' '[:lower:]')
case $user_input_lower in
  amd)
    gpuType="amd"
    ;;
  intel)
    gpuType="intel"
    ;;
  vm)
    gpuType="vm"
    ;;
  nvidia)
    gpuType="nvidia"
    ;;
  intel-nvidia)
    gpuType="intel-nvidia"
    ;;
  *)
    echo "Option Entered Not Available, Falling Back To [ amd ] Option."
    sleep 1
    gpuType="amd"
    ;;
esac
sed -i "/^\s*gpuType[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gpuType\"/" ./options.nix

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > hardware.nix

echo "-----"

echo "Now Going To Build YonOS, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#$hostName

if [ $userName != $installusername ]; then
  cd
  cp -r yonos /home/$userName/
  sudo chown -R $userName:users /home/$userName/yonos
  echo "Ensuring YonOS repository is in your users HOME directory."
fi

echo "-----"

echo "YonOS Has Been Installed!"
echo "Please use responsibly."
