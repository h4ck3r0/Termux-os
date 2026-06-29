#!/bin/bash
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;93m'
B='\033[1;94m'
C='\033[1;96m'
W='\033[1;97m'
RS='\033[0m'

# Detect repo directory regardless of folder name (Termux-os / termux-os / etc)
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

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

do_full_setup()  { apt update && apt upgrade -y; pkg install zsh fish git figlet toilet ruby wget curl bat eza -y; gem install lolcat; clear; cd "$REPO_DIR"/.object/ && cp -r 'ANSI Shadow.flf' $PREFIX/share/figlet/ASCII-Shadow.flf; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; mkdir -p ~/.config/fish; pkg install toilet figlet eza -y; cd "$REPO_DIR"/.object; rm -rf ~/.termux/colors.properties; rm -rf "$PREFIX"/etc/motd; cp -r .colors.properties ~/.termux/colors.properties; cp -r .termux.properties ~/.termux.properties; curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf > ~/.termux/font.ttf; cp -r .1fishrc ~/.config/fish/config.fish; clear; termux-open-url h4ck3r.me; termux-reload-settings; cd "$REPO_DIR" ; bash os.sh; }
do_zsh_setup()   { rm -rf ~/.zshrc; git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh; cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc; cd "$REPO_DIR" ; bash os.sh; }
do_zsh_switch()  { pkg install zsh; chsh -s zsh; cd "$REPO_DIR" ; bash os.sh; }
do_bash_switch() { chsh -s bash; cd "$REPO_DIR" ; bash os.sh; }
do_zsh_banner()  { rm -rf ~/.zshrc; cd "$REPO_DIR"/.object; bash .2.sh; clear ; cd "$REPO_DIR" ; bash os.sh; }
do_zsh_theme()   { cd "$REPO_DIR"/.object; bash .1.sh; clear ; cd "$REPO_DIR" ; bash os.sh; }
do_zsh_plugins() { cd "$REPO_DIR"/.object; rm -rf ~/.zshrc; chsh -s zsh; bash .3.sh; clear ; cd "$REPO_DIR" ; bash os.sh; }
do_fish_setup()  { pkg install fish; mkdir -p ~/.config/fish; cp ~/.config/fish/config.fish ~/.config/fish/config.fish.bak 2>/dev/null || true; cp "$REPO_DIR"/.object/.1fishrc ~/.config/fish/config.fish; cd "$REPO_DIR" ; bash os.sh; }
do_fish_switch() { pkg install fish; chsh -s fish; mkdir -p ~/.config/fish; cp "$REPO_DIR"/.object/.1fishrc ~/.config/fish/config.fish; cd "$REPO_DIR" ; bash os.sh; }
do_fish_banner() { chsh -s fish; mkdir -p ~/.config/fish; cd "$REPO_DIR"/.object; bash .1fish.sh; clear ; cd "$REPO_DIR" ; bash os.sh; }
do_fish_theme()  { chsh -s fish; mkdir -p ~/.config/fish; cd "$REPO_DIR"/.object; bash .2fish.sh; clear ; cd "$REPO_DIR" ; bash os.sh; }
do_fish_full()   { chsh -s fish; mkdir -p ~/.config/fish; cd "$REPO_DIR"/.object; bash .3fish.sh; clear ; cd "$REPO_DIR" ; bash os.sh; }
do_update()      { cd "$REPO_DIR"; git pull; bash os.sh; }
do_add_lock() {
    echo -e "\n${C}Initialising Security Protocol...${RS}"
    echo -ne "${Y}Create Access Key: ${RS}"
    read -s new_pass
    echo
    
    # Hash the new password
    new_pass_hash=$(echo -n "$new_pass" | sha256sum | cut -d' ' -f1)
    
    # Lock code for Bash/Zsh
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
    entered_hash=\$(echo -n \"\$pass_input\" | sha256sum | cut -d' ' -f1)
    if [ \"\$entered_hash\" = \"$new_pass_hash\" ]; then
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

    # Lock code for Fish (using fish syntax)
    lock_code_fish="#LOCK_START
clear
echo -e '\033[1;32m'
echo '  System check...'
sleep 0.2
echo '  Encrypted link established.'
sleep 0.2
clear
set attempt 1
while test \$attempt -le 3
    echo -e \"\n${C}╔══════════════════════════════════════╗\"
    echo -e \"║        ${R}SECURE SHELL ACCESS           ${C}║\"
    echo -e \"╚══════════════════════════════════════╝${RS}\"
    read -s -p \"${Y} [Attempt \$attempt/3] Enter Key: ${RS}\" pass_input
    echo
    set entered_hash (echo -n \"\$pass_input\" | sha256sum | cut -d' ' -f1)
    if test \"\$entered_hash\" = \"$new_pass_hash\"
        echo -e \"${G} ACCESS GRANTED.${RS}\"
        sleep 1
        clear
        break
    else
        echo -e \"${R} DENIED.${RS}\"
        if test \$attempt -eq 3
            exit
        end
        set attempt (math \$attempt + 1)
    end
end
#LOCK_END"

    add_to_top() {
        local file=$1
        local code=$2
        if [ -f "$file" ]; then
            echo "$code" > "$file.tmp"
            cat "$file" >> "$file.tmp"
            mv "$file.tmp" "$file"
        else
            echo "$code" > "$file"
        fi
    }

    add_to_top ~/.bashrc "$lock_code"
    [ -f ~/.zshrc ] && add_to_top ~/.zshrc "$lock_code"
    [ -f ~/.config/fish/config.fish ] && add_to_top ~/.config/fish/config.fish "$lock_code_fish"

    echo -e "${G}Lock Configured at the TOP of files.${RS}"
    sleep 2
    menu
}

do_remove_lock() {
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
    printf "\n${left_pad}${C}[${W}04${C}]${G} Bash Options"
    printf "\n${left_pad}${C}[${W}05${C}]${B} Security & Updates"
    printf "\n${left_pad}${C}[${W}06${C}]${Y} Termux Color Themes"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Exit Terminal\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_full_setup ;;
        2|02) zsh_menu ;;
        3|03) fish_menu ;;
        4|04) bash_menu ;;
        5|05) system_menu ;;
        6|06) color_theme_menu ;;
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
        1|01) do_zsh_setup   ;;
        2|02) do_zsh_switch  ;;
        3|03) do_zsh_banner  ;;
        4|04) do_zsh_theme   ;;
        5|05) do_zsh_plugins ;;
        0|00) menu ;;
        *) zsh_menu ;;
    esac
}

bash_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Switch to Bash Shell"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_bash_switch ;;
        0|00) menu ;;
        *) bash_menu ;;
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
        1|01) do_fish_setup   ;;
        2|02) do_fish_switch  ;;
        3|03) do_fish_banner  ;;
        4|04) do_fish_theme   ;;
        5|05) do_fish_full    ;;
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
        1|01) do_add_lock    ;;
        2|02) do_remove_lock ;;
        3|03) do_update      ;;
        0|00) menu ;;
        *) system_menu ;;
    esac
}

color_theme_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Default (Gunmetal)"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Dracula Theme"
    printf "\n${left_pad}${C}[${W}03${C}]${G} Nord Theme"
    printf "\n${left_pad}${C}[${W}04${C}]${G} Monokai Theme"
    printf "\n${left_pad}${C}[${W}05${C}]${G} Solarized Dark Theme"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_set_theme "default" ;;
        2|02) do_set_theme "dracula" ;;
        3|03) do_set_theme "nord" ;;
        4|04) do_set_theme "monokai" ;;
        5|05) do_set_theme "solarized" ;;
        0|00) menu ;;
        *) color_theme_menu ;;
    esac
}

do_set_theme() {
    local theme=$1
    local theme_file="$REPO_DIR"/.object/.colors_"${theme}".properties
    if [ -f "$theme_file" ]; then
        mkdir -p ~/.termux
        rm -f ~/.termux/colors.properties
        cp "$theme_file" ~/.termux/colors.properties
        if command -v termux-reload-settings &>/dev/null; then
            termux-reload-settings
        fi
        echo -e "${G}Applied ${theme} theme successfully!${RS}"
    else
        echo -e "${R}Theme file not found: ${theme_file}${RS}"
    fi
    sleep 2
    color_theme_menu
}
menu
