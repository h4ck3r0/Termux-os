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
    
    local R="\e[1;31m" 
    local G="\e[1;32m" 
    local C="\e[1;36m" 
    local W="\e[1;37m"
    local Y="\e[1;33m" 
    local N="\e[0m"    

    echo -e "${C} ______                              ${R}  ___  ____"
    echo -e "${C}/_  __/__  _________ ___  __  ___  __${R} / _ \/ __/"
    echo -e "${C} / / / _ \/ ___/ __ '__ \/ / / / |/_/${R}/ // /\ \  "
    echo -e "${C}/_/  \___/_/  /_/ /_/ /_/\__,_/_/|_| ${R}\___/___/  "
    echo -e "                                      "
    echo -e "${W}      --[ ${G}System Optimization Tool ${W}]--       "
    echo -e ""
    
    echo -e "${R} [!]${W} Author  : ${C}Raj Aryan (H4Ck3R0)"
    echo -e "${R} [!]${W} Version : ${Y}v2.5 (Stable)"
    echo -e "${R} [!]${W} Youtube : ${W}youtube.com/h4ck3r0"
    echo -e "${R} [!]${W} GitHub  : ${W}github.com/H4Ck3R0"
    echo -e ""
    
    echo -e "${G} ==============================================${N}"
    echo -e ""
}

banner

1line() { apt update && apt upgrade; pkg install zsh git figlet toilet ruby wget curl -y; gem install lolcat; clear; cd ~/Termux-os/.object/ && cp -r 'ANSI Shadow.flf' $PREFIX/share/figlet/ASCII-Shadow.flf; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; pkg install toilet figlet exa -y; cd ~/Termux-os/.object; rm -rf ~/.termux/colors.properties; rm -rf /data/data/com.termux/files/usr/etc/motd; cp -r .colors.properties ~/.termux/colors.properties; cp -r .termux.properties ~/.termux.properties; curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf; clear; cd ~/Termux-os ; bash os.sh; termux-open-url h4ck3r.me && termux-reload-settings; }
2line() { rm -rf ~/.zshrc; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc; cd ~/Termux-os ; bash os.sh; }
3line() { pkg install zsh; chsh -s zsh; cd ~/Termux-os ; bash os.sh; }
4line() { chsh -s bash; cd ~/Termux-os ; bash os.sh; }
5line() { rm -rf ~/.zshrc; cd ~/Termux-os/.object; bash .2.sh; clear ; cd ~/Termux-os ; bash os.sh; }
6line() { cd ~/Termux-os/.object; bash .1.sh; clear ; cd ~/Termux-os ; bash os.sh; }
7line() { cd ~/Termux-os/.object; rm -rf ~/.zshrc; chsh -s zsh; bash .3.sh; clear ; cd ~/Termux-os ; bash os.sh; }
8line() { rm -rf ~/Termux-os; cd; git clone https://github.com/h4ck3r0/Termux-os; cd ~/Termux-os ; bash os.sh; }
9line() {
    echo -e "\n${C}Initialising Security Protocol...${RS}"
    echo -ne "${Y}Create Access Key: ${RS}"
    read -s new_pass
    echo
    lock_code="#LOCK_START
    clear
    echo -e '\033[1;32m'
    echo '  System check...'
    sleep 0.2
    echo '  Encrypted link established.'
    sleep 0.2
    clear
    attempt=1
    while [ \$attempt -le 3 ]; do
        echo -e \"\n${C}╔══════════════════════════════════════╗\"
        echo -e \"║        ${R}SECURE SHELL ACCESS           ${C}║\"
        echo -e \"╚══════════════════════════════════════╝${RS}\"
        echo -ne \"${Y} [Attempt \$attempt/3] Enter Key: ${RS}\"
        read -s pass_input
        echo
        if [ \"\$pass_input\" == \"$new_pass\" ]; then
            echo -e \"${G} ACCESS GRANTED.${RS}\"
            sleep 1
            clear
            break
        else
            echo -e \"${R} DENIED.${RS}\"
            if [ \$attempt -eq 3 ]; then
                exit
            fi
            ((attempt++))
        fi
    done
    #LOCK_END"
    echo "$lock_code" >> ~/.bashrc
    [ -f ~/.zshrc ] && echo "$lock_code" >> ~/.zshrc
    echo -e "${G}Lock Configured. Your files remain untouched.${RS}"
    sleep 2
    menu
}

10line() {
    sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.bashrc
    [ -f ~/.zshrc ] && sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.zshrc
    echo -e "${R}Security Protocol Deactivated.${RS}"
    sleep 2
    menu
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
    printf "\n${left_pad}${R}[${W}9${R}]${B} Add Cyber Lock"
    printf "\n${left_pad}${R}[${W}10${R}]${R} Remove Lock"
    printf "\n${left_pad}${R}[${W}0${R}]${G} Exit\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
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
        9) 9line ;;
        10) 10line ;;
        0) exit ;;
        *) menu ;;
    esac
}
menu
