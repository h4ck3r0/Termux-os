#!/usr/bin/bash
git clone https://github.com/oh-my-fish/oh-my-fish.git ~/.local/share/omf --depth=1 2>/dev/null || true

clear
PUT(){ echo -en "\033[${1};${2}H";}
clear;toilet -t -f mono12  "H4Ck3R" --gay -F border
echo ""
PUT 11 40
echo -e "\e[92mBy\e[1;93m RajAryan\e[1;95m /\e[1;96m H4Ck3R0 "
PUT 12 3
echo ""
echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m by \e[1;36mRaj Aryan \e[93m/ \e[100;92myoutube.com/h4ck3r_raj\e[0m"
echo
echo -e "  \e[101;1;39mNOTE\e[0;1;33m Use upto 9 words\e[0m"
echo ""
cd ~/Termux-os/.object
echo -e '\e[1;96m'
read -p '  Type Banner Name ❯ ' name
sed -e "s/\PROC/$name/g" .2fishrc > ~/temp_fish_config.tmp
mv ~/temp_fish_config.tmp ~/.config/fish/config.fish

echo  ""
echo -e '\e[1;96m'
read -p '  Type Shell Name ❯ ' name
sed -i -e "s/\H4ck3r/$name/g" ~/.config/fish/config.fish

# Create directories if they don't exist
mkdir -p ~/.config/fish/conf.d

# Add fzf keybindings if available
if command -v fzf &> /dev/null; then
    echo "# FZF Integration
bind \cF 'fzf | xargs -I {} echo {}'
" >> ~/.config/fish/conf.d/fzf.fish 2>/dev/null || true
fi
