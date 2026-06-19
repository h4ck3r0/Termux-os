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
    echo -e "${W}      --[ ${G}Termux Optimization Tool ${W}]--       "
    echo -e ""
    
    echo -e "${R} [!]${W} Author  : ${C}Raj Aryan (H4Ck3R0)"
    echo -e "${R} [!]${W} Version : ${Y}v3.5 (Stable)"
    echo -e "${R} [!]${W} Youtube : ${W}youtube.com/h4ck3r0"
    echo -e "${R} [!]${W} GitHub  : ${W}github.com/H4Ck3R0"
    echo -e ""
    
    echo -e "${G} ==============================================${N}"
    echo -e ""
}

banner

1line() { apt update && apt upgrade; pkg install zsh fish git figlet toilet ruby wget curl bat exa -y; gem install lolcat; clear; cd ~/Termux-os/.object/ && cp -r 'ANSI Shadow.flf' $PREFIX/share/figlet/ASCII-Shadow.flf; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; mkdir -p ~/.config/fish; pkg install toilet figlet exa -y; cd ~/Termux-os/.object; rm -rf ~/.termux/colors.properties; rm -rf /data/data/com.termux/files/usr/etc/motd; cp -r .colors.properties ~/.termux/colors.properties; cp -r .termux.properties ~/.termux.properties; curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf; cp -r .1fishrc ~/.config/fish/config.fish; clear; cd ~/Termux-os ; bash os.sh; termux-open-url h4ck3r.me && termux-reload-settings; }
2line() { rm -rf ~/.zshrc; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc; cd ~/Termux-os ; bash os.sh; }
3line() { pkg install zsh; chsh -s zsh; cd ~/Termux-os ; bash os.sh; }
4line() { chsh -s bash; cd ~/Termux-os ; bash os.sh; }
5line() { rm -rf ~/.zshrc; cd ~/Termux-os/.object; bash .2.sh; clear ; cd ~/Termux-os ; bash os.sh; }
6line() { cd ~/Termux-os/.object; bash .1.sh; clear ; cd ~/Termux-os ; bash os.sh; }
7line() { cd ~/Termux-os/.object; rm -rf ~/.zshrc; chsh -s zsh; bash .3.sh; clear ; cd ~/Termux-os ; bash os.sh; }
11line() { pkg install fish; mkdir -p ~/.config/fish; cp ~/.config/fish/config.fish ~/.config/fish/config.fish.bak 2>/dev/null || true; cp ~/Termux-os/.object/.1fishrc ~/.config/fish/config.fish; cd ~/Termux-os ; bash os.sh; }
12line() { pkg install fish; chsh -s fish; mkdir -p ~/.config/fish; cp ~/Termux-os/.object/.1fishrc ~/.config/fish/config.fish; cd ~/Termux-os ; bash os.sh; }
13line() { mkdir -p ~/.config/fish; cd ~/Termux-os/.object; bash .1fish.sh; clear ; cd ~/Termux-os ; bash os.sh; }
14line() { mkdir -p ~/.config/fish; cd ~/Termux-os/.object; bash .2fish.sh; clear ; cd ~/Termux-os ; bash os.sh; }
15line() { mkdir -p ~/.config/fish; cd ~/Termux-os/.object; bash .3fish.sh; clear ; cd ~/Termux-os ; bash os.sh; }
10line() { rm -rf ~/Termux-os; cd; git clone https://github.com/h4ck3r0/Termux-os; cd ~/Termux-os ; bash os.sh; }
8line() {
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
    if [ \"\$pass_input\" = \"$new_pass\" ]; then
        echo -e \"${G} ACCESS GRANTED.${RS}\"
        sleep 1
        clear
        break
    else
        echo -e \"${R} DENIED.${RS}\"
        if [ \$attempt -eq 3 ]; then
            exit
        fi
        attempt=\$((attempt + 1))
    fi
done
#LOCK_END"

    add_to_top() {
        local file=$1
        if [ -f "$file" ]; then
            echo "$lock_code" > "$file.tmp"
            cat "$file" >> "$file.tmp"
            mv "$file.tmp" "$file"
        else
            echo "$lock_code" > "$file"
        fi
    }

    add_to_top ~/.bashrc
    [ -f ~/.zshrc ] && add_to_top ~/.zshrc
    [ -f ~/.config/fish/config.fish ] && add_to_top ~/.config/fish/config.fish

    echo -e "${G}Lock Configured at the TOP of files.${RS}"
    sleep 2
    menu
}

9line() {
    sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.bashrc
    [ -f ~/.zshrc ] && sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.zshrc
    [ -f ~/.config/fish/config.fish ] && sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.config/fish/config.fish
    echo -e "${R}Security Protocol Deactivated.${RS}"
    sleep 2
    menu
}

menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Necessary Setup"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Zsh Options"
    printf "\n${left_pad}${C}[${W}03${C}]${G} Fish Options"
    printf "\n${left_pad}${C}[${W}04${C}]${G} Bash Shell"
    printf "\n${left_pad}${C}[${W}05${C}]${B} Security & Updates"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Exit Terminal\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) 1line ;;
        2|02) zsh_menu ;;
        3|03) fish_menu ;;
        4|04) 4line ;;
        5|05) system_menu ;;
        0|00) exit ;;
        *) menu ;;
    esac
}

zsh_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Zsh Setup"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Switch to Zsh Shell"
    printf "\n${left_pad}${C}[${W}03${C}]${Y} Customize Zsh Banner"
    printf "\n${left_pad}${C}[${W}04${C}]${Y} Customize Zsh Theme"
    printf "\n${left_pad}${C}[${W}05${C}]${Y} Install Highlight / AutoSuggest"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) 2line ;;
        2|02) 3line ;;
        3|03) 5line ;;
        4|04) 6line ;;
        5|05) 7line ;;
        0|00) menu ;;
        *) zsh_menu ;;
    esac
}

fish_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Fish Setup"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Switch to Fish Shell"
    printf "\n${left_pad}${C}[${W}03${C}]${Y} Customize Fish Banner"
    printf "\n${left_pad}${C}[${W}04${C}]${Y} Customize Fish Theme"
    printf "\n${left_pad}${C}[${W}05${C}]${Y} Banner + Theme Setup"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) 11line ;;
        2|02) 12line ;;
        3|03) 13line ;;
        4|04) 14line ;;
        5|05) 15line ;;
        0|00) menu ;;
        *) fish_menu ;;
    esac
}

system_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${B} Add Cyber Lock ${R}(Top Security)"
    printf "\n${left_pad}${C}[${W}02${C}]${R} Remove Lock"
    printf "\n${left_pad}${C}[${W}03${C}]${W} Update Script"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) 8line ;;
        2|02) 9line ;;
        3|03) 10line ;;
        0|00) menu ;;
        *) system_menu ;;
    esac
}
menu
