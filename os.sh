#!/bin/bash
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;93m'
B='\033[1;94m'
C='\033[1;96m'
W='\033[1;97m'
RS='\033[0m'


term_width=$(tput cols)
BOX_WIDTH=$(( term_width > 60 ? 58 : term_width - 2 ))
margin=$(( (term_width - BOX_WIDTH) / 2 ))
left_pad=$(printf '%*s' "$margin" "")

draw_line() {
    printf "${C}${left_pad}%s" "$1"
    for ((i=0; i<BOX_WIDTH-2; i++)); do printf "═"; done
    printf "%s${RS}\n" "$2"
}

print_center() {
    local text="$1"
    local color="$2"
    local len=${#text}
    local space_len=$(( (BOX_WIDTH - 2 - len) / 2 ))
    printf "${C}${left_pad}║%*s${color}%s${C}%*s║${RS}\n" $space_len "" "$text" $(( BOX_WIDTH - 2 - len - space_len )) ""
}


banner() {
    clear
    echo -e "${R} ________     _____    ______       __    __     __    __   __     __  " 
    echo -e "${R}(___  ___)   / ___/   (    __ \      \ \  / /     ) )  ( (  (_ \   / _) " 
    echo -e "${C}    ) )     ( (__      ) (__) )      () \/ ()     ( (    ) )   \ \_/ /   " 
    echo -e "${C}   ( (       ) __)    (    __/       / _  _ \      ) )  ( (     \   /    "  
    echo -e "${B}    ) )     ( (        ) \ \  _     / / \/ \ \    ( (    ) )     / _ \    " 
    echo -e "${B}   ( (       \ \___   ( ( \ \_))   /_/      \_\    ) \__/ (    _/ / \ \_  " 
    echo -e "${G}   /__\       \____\   )_) \__/   (/          \)  \______/  (__/   \__)"
    echo -e ""
    echo -e "${left_pad}${R}Youtube${C} / ${W}youtube.com/h4ck3r0"
    echo -e "${left_pad}${R}Github${C} / ${Y}H4Ck3R0"
    echo -e "${left_pad}${R}Telegram${C} / ${G}H4Ck3R_0"
    echo ""
    draw_line "╔" "╗"
    print_center "[√] by Raj Aryan / youtube.com/h4ck3r0" "$G"
    draw_line "╚" "╝"
}


1line() {
    apt update && apt upgrade
    pkg install zsh -y
    pkg install git -y
    pkg install figlet toilet -y
    pkg install ruby -y
    pkg install wget -y
    gem install lolcat 
    pkg install curl -y
    pkg install zsh -y
    clear
    cd ~/Termux-os/.object/ && cp -r 'ANSI Shadow.flf' $PREFIX/share/figlet/ASCII-Shadow.flf 
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    pkg install toilet figlet exa -y
    cd ~/Termux-os/.object
    rm -rf ~/.termux/colors.properties
    rm -rf /data/data/com.termux/files/usr/etc/motd
    cp -r .colors.properties ~/.termux/colors.properties
    cp -r .termux.properties ~/.termux/termux.properties
    curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf 
    clear
    cd ~/Termux-os ; bash os.sh
    termux-open-url h4ck3r.me && termux-reload-settings
}

2line() {
    rm -rf ~/.zshrc
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    cd ~/Termux-os ; bash os.sh
}

3line() {
    pkg install zsh
    chsh -s zsh
    cd ~/Termux-os ; bash os.sh
}

4line() {
    chsh -s bash
    cd ~/Termux-os ; bash os.sh
}

5line() {
    rm -rf ~/.zshrc
    cd ~/Termux-os/.object
    bash .2.sh
    clear ; cd ~/Termux-os ; bash os.sh
}

6line() {
    cd ~/Termux-os/.object
    bash .1.sh
    clear ; cd ~/Termux-os ; bash os.sh
}

7line() {
    cd ~/Termux-os/.object
    rm -rf ~/.zshrc
    chsh -s zsh
    bash .3.sh
    clear ; cd ~/Termux-os ; bash os.sh
}

8line() {
    rm -rf ~/Termux-os
    cd
    git clone https://github.com/h4ck3r0/Termux-os
    cd ~/Termux-os ; bash os.sh
}


menu() {
    banner
    printf "\n${left_pad}${R}[${W}1${R}]${G} Necessary Setup"
    printf "\n${left_pad}${R}[${W}2${R}]${G} Zsh Setup"
    printf "\n${left_pad}${R}[${W}3${R}]${G} Zsh Shell"
    printf "\n${left_pad}${R}[${W}4${R}]${G} Bash Shell"
    printf "\n${left_pad}${R}[${W}5${R}]${G} Zsh Banner"
    printf "\n${left_pad}${R}[${W}6${R}]${G} Zsh Theme"
    printf "\n${left_pad}${R}[${W}7${R}]${G} Highlight / AutoSuggest"
    printf "\n${left_pad}${R}[${W}8${R}]${G} Update"
    printf "\n${left_pad}${R}[${W}9${R}]${G} Exit\n\n"
    
    echo -ne "${left_pad}${C}Choose Option : ${RS}"
    read a
    case $a in
        1) 1line ;;
        2) 2line ;;
        3) 3line ;;
        4) 4line ;;
        5) 5line ;;
        6) 6line ;;
        7) 7line ;;
        8) 8line ;;
        9) exit ;;
        *) printf "\033[1;91m Invalid input!!!\n"; sleep 1; menu ;;
    esac
}

menu
