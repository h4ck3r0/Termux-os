#!/usr/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Download and install ble.sh
echo -e "\e[1;32m[*] Downloading and installing ble.sh (Bash Line Editor)..."
# Check if curl and tar are available
if command -v curl &>/dev/null && command -v tar &>/dev/null; then
    curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz -o ble-nightly.tar.xz
    tar -xJf ble-nightly.tar.xz
    mkdir -p ~/.local/share/blesh
    cp -a ble-nightly/* ~/.local/share/blesh/
    rm -rf ble-nightly ble-nightly.tar.xz
    echo -e "\e[1;32m[√] ble.sh installed successfully."
else
    echo -e "\e[1;31m[!] curl and tar are required to install ble.sh."
fi

clear
PUT() { printf "\033[%d;%dH" "$1" "$2"; }
clear;toilet -t -f mono12  "H4Ck3R" --gay -F border
echo ""
PUT 11 40
echo -e "\e[92mBy\e[1;93m RajAryan\e[1;95m /\e[1;96m H4Ck3R0 "
PUT 12 3
echo ""
echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m by \e[1;36mRaj Aryan \e[93m/ \e[100;92myoutube.com/h4ck3r0\e[0m"
echo
echo -e "  \e[101;1;39mNOTE\e[0;1;33m Use upto 9 words\e[0m"
echo ""
cd "$SCRIPT_DIR"
echo -e '\e[1;96m'
read -p '  Type Banner Name ❯ ' banner_name
echo  ""
read -p '  Type Shell Name ❯ ' shell_name

# Generate the .bashrc from template
sed -e "s/PROC/$banner_name/g" -e "s/H4ck3r/$shell_name/g" .1bashrc > ~/.bashrc
echo -e "\e[1;32m[√] Bash prompt and plugins setup completed!"
sleep 2
