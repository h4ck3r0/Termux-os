#!/bin/bash
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;93m'
B='\033[1;94m'
C='\033[1;96m'
W='\033[1;97m'
RS='\033[0m'

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

ensure_dependencies() {
    echo -e "${Y}[*] Checking dependencies...${RS}"
    local missing=()
    for pkg in zsh fish git figlet toilet ruby wget curl bat eza unzip xz-utils ca-certificates; do
        if ! command -v "$pkg" &>/dev/null; then
            missing+=("$pkg")
        fi
    done
    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${Y}[*] Installing missing dependencies: ${missing[*]}...${RS}"
        pkg update -y && pkg install "${missing[@]}" -y
    fi
}

do_full_setup() {
    ensure_dependencies
    if command -v gem &>/dev/null && ! command -v lolcat &>/dev/null; then
        echo -e "${Y}[*] Installing lolcat gem...${RS}"
        gem install lolcat -y 2>/dev/null || gem install lolcat
    fi
    mkdir -p ~/.termux
    [ -f "$REPO_DIR/.object/.termux.properties" ] && cp "$REPO_DIR/.object/.termux.properties" ~/.termux/termux.properties
    [ -f "$REPO_DIR/.object/.colors.properties" ] && cp "$REPO_DIR/.object/.colors.properties" ~/.termux/colors.properties
    
    if [ -f "$REPO_DIR/.object/ANSI Shadow.flf" ]; then
        mkdir -p "$PREFIX/share/figlet"
        cp "$REPO_DIR/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf"
    fi

    if command -v termux-reload-settings &>/dev/null; then
        termux-reload-settings
    fi
    echo -e "${G}[√] Necessary Setup completed!${RS}"
    sleep 2
    menu
}

# Shell installation logic
do_zsh_setup() {
    ensure_dependencies
    if [ ! -d ~/.oh-my-zsh ]; then
        echo -e "${Y}[*] Cloning Oh My Zsh...${RS}"
        git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh --depth=1
    fi
    if [ ! -d ~/.oh-my-zsh/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions --depth=1
    fi
    if [ ! -d ~/.oh-my-zsh/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting --depth=1
    fi
    do_customize_prompts_menu "zsh"
}

do_zsh_switch() {
    pkg install zsh -y
    local zsh_path=$(command -v zsh)
    if [ -n "$zsh_path" ]; then
        chsh -s "$zsh_path"
        echo -e "${G}[√] Shell switched to Zsh. Reloading session...${RS}"
        sleep 2
        exec "$zsh_path"
    else
        echo -e "${R}[!] Zsh binary not found. Shell not switched.${RS}"
        sleep 2
        zsh_menu
    fi
}

do_bash_switch() {
    local bash_path=$(command -v bash)
    if [ -n "$bash_path" ]; then
        chsh -s "$bash_path"
        echo -e "${G}[√] Shell switched to Bash. Reloading session...${RS}"
        sleep 2
        exec "$bash_path"
    else
        echo -e "${R}[!] Bash binary not found. Shell not switched.${RS}"
        sleep 2
        bash_menu
    fi
}

do_bash_setup() {
    ensure_dependencies
    if [ ! -d ~/.local/share/blesh ]; then
        echo -e "${Y}[*] Downloading and installing ble.sh (Bash Line Editor)...${RS}"
        mkdir -p /tmp
        curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz -o /tmp/ble-nightly.tar.xz 2>/dev/null || curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz -o ~/.termux/ble-nightly.tar.xz
        local tar_file="/tmp/ble-nightly.tar.xz"
        [ ! -f "$tar_file" ] && tar_file="$HOME/.termux/ble-nightly.tar.xz"
        
        tar -xJf "$tar_file" -C "$HOME/.termux/"
        mkdir -p ~/.local/share/blesh
        cp -a "$HOME/.termux/ble-nightly/"* ~/.local/share/blesh/
        rm -rf "$HOME/.termux/ble-nightly" "$tar_file"
    fi
    do_customize_prompts_menu "bash"
}

do_fish_setup() {
    ensure_dependencies
    mkdir -p ~/.config/fish
    do_customize_prompts_menu "fish"
}

do_fish_switch() {
    pkg install fish -y
    local fish_path=$(command -v fish)
    if [ -n "$fish_path" ]; then
        chsh -s "$fish_path"
        echo -e "${G}[√] Shell switched to Fish. Reloading session...${RS}"
        sleep 2
        exec "$fish_path"
    else
        echo -e "${R}[!] Fish binary not found. Shell not switched.${RS}"
        sleep 2
        fish_menu
    fi
}

# Unified prompts customization configuration
do_customize_prompts_menu() {
    local shell=$1
    banner
    printf "\n${left_pad}${C}───[${W} Customizing ${shell} prompt & banner ${C}]───"
    
    echo -ne "\n${left_pad}${Y}[?]${W} Enter Welcome Banner Text (Default: Termux-OS): ${RS}"
    read banner_text
    [ -z "$banner_text" ] && banner_text="Termux-OS"
    
    echo -ne "${left_pad}${Y}[?]${W} Enter Shell Username (Default: H4ck3r): ${RS}"
    read username
    [ -z "$username" ] && username="H4ck3r"
    
    banner
    printf "\n${left_pad}${C}───[${W} Select FIGlet Font Style ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} ASCII-Shadow (Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Standard"
    printf "\n${left_pad}${C}[${W}3${C}]${G} Slant"
    printf "\n${left_pad}${C}[${W}4${C}]${G} Doom"
    printf "\n${left_pad}${C}[${W}5${C}]${G} Block\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read font_sel
    local fig_font="ASCII-Shadow"
    case $font_sel in
        2) fig_font="Standard" ;;
        3) fig_font="Slant" ;;
        4) fig_font="Doom" ;;
        5) fig_font="Block" ;;
    esac
    
    banner
    printf "\n${left_pad}${C}───[${W} Select Banner Color Style ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Lolcat (Rainbow)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Matrix (Glowing Green)"
    printf "\n${left_pad}${C}[${W}3${C}]${G} Cyber (Cyan/Magenta)"
    printf "\n${left_pad}${C}[${W}4${C}]${G} Plain White\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read color_sel
    local color_style="lolcat"
    case $color_sel in
        2) color_style="matrix" ;;
        3) color_style="cyber" ;;
        4) color_style="white" ;;
    esac
    
    banner
    printf "\n${left_pad}${C}───[${W} Select Prompt Symbol ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} ❯ (Standard Arrow)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} \$ (Classic Unix)"
    printf "\n${left_pad}${C}[${W}3${C}]${G} ⚡ (Power Bolt)"
    printf "\n${left_pad}${C}[${W}4${C}]${G} 🚀 (Rocket)"
    printf "\n${left_pad}${C}[${W}5${C}]${G} 💀 (Skull)"
    printf "\n${left_pad}${C}[${W}6${C}]${G} 🔥 (Flame)"
    printf "\n${left_pad}${C}[${W}7${C}]${G} 👾 (Alien)\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read sym_sel
    local prompt_sym="❯"
    case $sym_sel in
        2) prompt_sym="\$" ;;
        3) prompt_sym="⚡" ;;
        4) prompt_sym="🚀" ;;
        5) prompt_sym="💀" ;;
        6) prompt_sym="🔥" ;;
        7) prompt_sym="👾" ;;
    esac
    
    banner
    printf "\n${left_pad}${C}───[${W} Select Prompt Layout Style ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Cyberpunk Outline (Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Minimalist (Single Line)"
    printf "\n${left_pad}${C}[${W}3${C}]${G} Git-Aware (Classic styling)\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read layout_sel
    local prompt_layout="cyberpunk"
    case $layout_sel in
        2) prompt_layout="minimalist" ;;
        3) prompt_layout="git-aware" ;;
    esac
    
    apply_shell_customizations "$shell" "$banner_text" "$username" "$fig_font" "$color_style" "$prompt_sym" "$prompt_layout"
}

apply_shell_customizations() {
    local shell=$1
    local banner_text=$2
    local username=$3
    local fig_font=$4
    local color_style=$5
    local prompt_sym=$6
    local prompt_layout=$7
    
    ensure_dependencies
    
    local figlet_dir=""
    if [ -n "$PREFIX" ]; then
        figlet_dir="$PREFIX/share/figlet"
    else
        figlet_dir="$HOME/.local/share/figlet"
    fi
    mkdir -p "$figlet_dir"

    # Copy bundled ASCII-Shadow font if it exists
    if [ -f "$REPO_DIR/.object/ANSI Shadow.flf" ]; then
        cp "$REPO_DIR/.object/ANSI Shadow.flf" "$figlet_dir/ASCII-Shadow.flf"
    fi

    # Ensure other selected standard fonts are downloaded if selected and missing
    if [ "$fig_font" != "ASCII-Shadow" ]; then
        if [ ! -f "$figlet_dir/$fig_font.flf" ]; then
            echo -e "${Y}[*] Downloading figlet font: $fig_font...${RS}"
            curl -s -L "https://raw.githubusercontent.com/patorjk/figlet.js/master/fonts/$fig_font.flf" -o "$figlet_dir/$fig_font.flf"
            # Fallback if download failed
            if [ ! -f "$figlet_dir/$fig_font.flf" ] || [ ! -s "$figlet_dir/$fig_font.flf" ]; then
                echo -e "${R}[!] Failed to download $fig_font.flf, using Standard.${RS}"
                fig_font="Standard"
                if [ ! -f "$figlet_dir/Standard.flf" ]; then
                    curl -s -L "https://raw.githubusercontent.com/patorjk/figlet.js/master/fonts/Standard.flf" -o "$figlet_dir/Standard.flf"
                fi
            fi
        fi
    fi

    local banner_script="$HOME/.termux-os-banner.sh"
    cat << 'EOF' > "$banner_script"
#!/bin/bash
clear
echo -e '\033[1;32m[*] BOOTING TERMUX-OS...'
echo -ne '\033[1;36m[LOADING MODULES] \033[1;32m'
for i in {1..25}; do echo -ne '█'; sleep 0.01; done
echo -e '\033[0m'
sleep 0.2
clear

BOX_WIDTH=56
cyan='\033[0;36m'
reset='\033[0m'
EOF

    echo "FIGLET_DIR=\"$figlet_dir\"" >> "$banner_script"

    cat << 'EOF' >> "$banner_script"
print_center() { local text="$1"; local len=${#text}; local space_len=$(( (BOX_WIDTH - 2 - len) / 2 )); printf "${cyan} ║%*s${reset}%s${cyan}%*s║${reset}\n" $space_len "" "$text" $(( BOX_WIDTH - 2 - len - space_len )) ""; }
draw_line() { local char=$1; local end=$2; printf "${cyan} %s" "$char"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "═"; done; printf "%s${reset}\n" "$end"; }

draw_line '╔' '╗'
print_center ''
EOF

    if [ "$color_style" = "lolcat" ]; then
        if command -v gem &>/dev/null && ! command -v lolcat &>/dev/null; then
            gem install lolcat -y 2>/dev/null || gem install lolcat
        fi
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null | lolcat 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
    elif [ "$color_style" = "matrix" ]; then
        echo "echo -e '\\033[1;32m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    elif [ "$color_style" = "cyber" ]; then
        echo "echo -e '\\033[1;36m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    else
        echo "echo -e '\\033[1;37m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    fi
    
    cat << EOF >> "$banner_script"
print_center ''
print_center 'SYSTEM: ONLINE  |  USER: $username'
if command -v termux-battery-status &>/dev/null; then
    bat_info=\$(termux-battery-status | grep -E 'percentage|status' | tr -d '", ' | paste -sd ' | ')
    [ -n "\$bat_info" ] && print_center "\$bat_info"
fi
if command -v free &>/dev/null; then
    mem_info=\$(free -m | awk '/Mem:/ {print "RAM: " \$3 "MB / " \$2 "MB"}')
    [ -n "\$mem_info" ] && print_center "\$mem_info"
fi
print_center 'SECURE CONNECTION ESTABLISHED'
print_center ''
draw_line '╚' '╝'
EOF

    chmod +x "$banner_script"
    if [ -f "$REPO_DIR/.object/ANSI Shadow.flf" ]; then
        mkdir -p "$PREFIX/share/figlet"
        cp "$REPO_DIR/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf"
    fi

    if [ "$shell" = "bash" ]; then
        [ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.bak
        
        echo "[[ -f ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh" > ~/.bashrc
        echo "bash $banner_script" >> ~/.bashrc
        
        if [ "$prompt_layout" = "cyberpunk" ]; then
            cat << 'EOF' >> ~/.bashrc
set_bash_prompt() {
    local EXIT="$?"
    local RED="\[\033[1;31m\]"
    local GREEN="\[\033[1;32m\]"
    local WHITE="\[\033[1;37m\]"
    local CYAN="\[\033[1;36m\]"
    local RESET="\[\033[0m\]"
    local git_info=""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            git_info=" \[\033[1;31m\](${branch}*)${RESET}"
        else
            git_info=" \[\033[1;32m\](${branch})${RESET}"
        fi
    fi
    local arrow="${GREEN}__SYMBOL__"
    if [ "$EXIT" -ne 0 ]; then
        arrow="${RED}__SYMBOL__"
    fi
    PS1="\n${RED}┌─[${GREEN}__USERNAME__${RED}@${WHITE}termux${RED}]─[${CYAN}\w${RED}]${git_info}\n${RED}└─╼ ${arrow} ${RESET}"
}
PROMPT_COMMAND=set_bash_prompt
EOF
        elif [ "$prompt_layout" = "minimalist" ]; then
            cat << 'EOF' >> ~/.bashrc
set_bash_prompt() {
    local EXIT="$?"
    local RED="\[\033[1;31m\]"
    local GREEN="\[\033[1;32m\]"
    local CYAN="\[\033[1;36m\]"
    local RESET="\[\033[0m\]"
    local arrow="${GREEN}__SYMBOL__"
    if [ "$EXIT" -ne 0 ]; then
        arrow="${RED}__SYMBOL__"
    fi
    PS1="${CYAN}\w ${arrow} ${RESET}"
}
PROMPT_COMMAND=set_bash_prompt
EOF
        else
            cat << 'EOF' >> ~/.bashrc
set_bash_prompt() {
    local EXIT="$?"
    local GREEN="\[\033[1;32m\]"
    local RED="\[\033[1;31m\]"
    local YELLOW="\[\033[1;33m\]"
    local BLUE="\[\033[1;34m\]"
    local RESET="\[\033[0m\]"
    local git_info=""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        git_info=" \[\033[1;33m\]git:(${branch})${RESET}"
    fi
    local arrow="${GREEN}__SYMBOL__"
    if [ "$EXIT" -ne 0 ]; then
        arrow="${RED}__SYMBOL__"
    fi
    PS1="\[\033[1;35m\]__USERNAME__ \[\033[1;34m\]\w${git_info} ${arrow} ${RESET}"
}
PROMPT_COMMAND=set_bash_prompt
EOF
        fi
        
        sed -i "s/__USERNAME__/$username/g" ~/.bashrc
        sed -i "s/__SYMBOL__/$prompt_sym/g" ~/.bashrc
        
        cat << 'EOF' >> ~/.bashrc
alias l='eza -la'
alias ls='command ls'
alias cat='command cat'
alias ll='eza -l'
EOF

    elif [ "$shell" = "zsh" ]; then
        [ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak
        
        cat << 'EOF' > ~/.zshrc
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="h4Ck3r"
plugins=(git)
source $HOME/.oh-my-zsh/oh-my-zsh.sh
[[ -f "$HOME"/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source "$HOME"/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f "$HOME"/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source "$HOME"/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bash ~/.termux-os-banner.sh
alias l='eza -la'
alias ls='command ls'
alias cat='command cat'
alias ll='eza -l'
EOF
        
        mkdir -p ~/.oh-my-zsh/themes
        local theme_file="$HOME/.oh-my-zsh/themes/h4Ck3r.zsh-theme"
        
        if [ "$prompt_layout" = "cyberpunk" ]; then
            cat << 'EOF' > "$theme_file"
autoload -U colors && colors
setopt prompt_subst
function parse_git_status() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo " %{$fg_bold[red]%}(${branch}*)%{$reset_color%}"
    else
        echo " %{$fg_bold[green]%}(${branch})%{$reset_color%}"
    fi
}
local user_info="%{$fg_bold[red]%}[%{$fg_bold[green]%}__USERNAME__%{$fg_bold[red]%}@%{$fg_bold[white]%}termux%{$fg_bold[red]%}]"
local current_dir="%{$fg_bold[red]%}[%{$fg_bold[cyan]%}%(5~|%-1~/…/%2~|%4~)%{$fg_bold[red]%}]"
local git_info='$(parse_git_status)'
local status_arrow="%(?.%{$fg_bold[green]%}__SYMBOL__.%{$fg_bold[red]%}__SYMBOL__)"
PROMPT="
%{$fg_bold[red]%}┌─${user_info}─${current_dir}${git_info}
%{$fg_bold[red]%}└─╼ ${status_arrow} %{$reset_color%}"
EOF
        elif [ "$prompt_layout" = "minimalist" ]; then
            cat << 'EOF' > "$theme_file"
autoload -U colors && colors
setopt prompt_subst
local current_dir="%{$fg[cyan]%}%~%{$reset_color%}"
local status_arrow="%(?.%{$fg_bold[green]%}__SYMBOL__.%{$fg_bold[red]%}__SYMBOL__)"
PROMPT="${current_dir} ${status_arrow} "
EOF
        else
            cat << 'EOF' > "$theme_file"
autoload -U colors && colors
setopt prompt_subst
function parse_git_status() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    echo " %{$fg[yellow]%}git:(${branch})%{$reset_color%}"
}
local user_info="%{$fg[magenta]%}__USERNAME__%{$reset_color%}"
local current_dir="%{$fg[blue]%}%~%{$reset_color%}"
local git_info='$(parse_git_status)'
local status_arrow="%(?.%{$fg_bold[green]%}__SYMBOL__.%{$fg_bold[red]%}__SYMBOL__)"
PROMPT="${user_info} ${current_dir}${git_info} ${status_arrow} "
EOF
        fi
        
        sed -i "s/__USERNAME__/$username/g" "$theme_file"
        sed -i "s/__SYMBOL__/$prompt_sym/g" "$theme_file"

    elif [ "$shell" = "fish" ]; then
        mkdir -p ~/.config/fish
        [ -f ~/.config/fish/config.fish ] && cp ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
        
        cat << 'EOF' > ~/.config/fish/config.fish
set fish_greeting
set -gx CLICOLOR 1
set -gx CLICOLOR_FORCE 1
set -gx fish_autosuggestion_enabled 1

bash ~/.termux-os-banner.sh

functions --erase ls
functions --erase cat
functions --erase ll
alias l='eza -la'
alias ls='command ls'
alias cat='command cat'
alias ll='eza -l'
EOF
        
        if [ "$prompt_layout" = "cyberpunk" ]; then
            cat << 'EOF' >> ~/.config/fish/config.fish
function fish_prompt
    set -l last_status $status
    echo
    set_color red
    printf "┌─["
    set_color green
    echo -n "__USERNAME__"
    set_color red
    echo -n "@"
    set_color white
    echo -n "termux"
    set_color red
    printf "]─["
    set_color cyan
    echo -n (prompt_pwd)
    set_color red
    echo -n "]"
    if command -v git >/dev/null 2>&1
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
            set -l status_count (git status --porcelain 2>/dev/null | count)
            if test $status_count -gt 0
                set_color red
                echo -n " ($branch*)"
            else
                set_color green
                echo -n " ($branch)"
            end
        end
    end
    echo
    set_color red
    printf "└─╼ "
    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    printf "__SYMBOL__ "
    set_color normal
end
EOF
        elif [ "$prompt_layout" = "minimalist" ]; then
            cat << 'EOF' >> ~/.config/fish/config.fish
function fish_prompt
    set -l last_status $status
    set_color cyan
    printf "%s " (prompt_pwd)
    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    printf "__SYMBOL__ "
    set_color normal
end
EOF
        else
            cat << 'EOF' >> ~/.config/fish/config.fish
function fish_prompt
    set -l last_status $status
    set_color magenta
    echo -n "__USERNAME__ "
    set_color blue
    echo -n (prompt_pwd)
    if command -v git >/dev/null 2>&1
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
            set_color yellow
            echo -n " git:($branch)"
        end
    end
    printf " "
    if test $last_status -eq 0
        set_color green
    else
        set_color red
    end
    printf "__SYMBOL__ "
    set_color normal
end
EOF
        fi
        
        sed -i "s/__USERNAME__/$username/g" ~/.config/fish/config.fish
        sed -i "s/__SYMBOL__/$prompt_sym/g" ~/.config/fish/config.fish
    fi
    
    # Auto-switch shell to the chosen one
    local target_shell_path=$(command -v "$shell")
    if [ -n "$target_shell_path" ] && [ "$SHELL" != "$target_shell_path" ]; then
        echo -e "${Y}[*] Auto-switching default shell to ${shell}...${RS}"
        if [ -d /data/data/com.termux ] || [ -n "$TERMUX_VERSION" ]; then
            # We are on Termux, chsh is passwordless
            chsh -s "$target_shell_path" &>/dev/null
        else
            # We are on standard Linux, chsh might require password
            echo -e "${Y}[!] You may be prompted for your password to change the default shell.${RS}"
            chsh -s "$target_shell_path"
        fi
        echo -e "${G}[√] Shell auto-switched! Reloading session into ${shell} now...${RS}"
        sleep 2
        exec "$target_shell_path"
    fi

    echo -e "${G}[√] ${shell} prompt & welcome banner set up successfully!${RS}"
    sleep 2
    case $shell in
        bash) bash_menu ;;
        zsh) zsh_menu ;;
        fish) fish_menu ;;
    esac
}

# Fonts Downloader Engine
do_install_font() {
    local font_zip=$1
    local font_name=$2
    
    ensure_dependencies
    
    local temp_zip="$HOME/.termux/temp_font.zip"
    mkdir -p "$HOME/.termux"
    
    echo -e "${Y}[*] Downloading ${font_name} Nerd Font...${RS}"
    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/${font_zip}" -o "${temp_zip}"
    if [ $? -ne 0 ] || [ ! -f "${temp_zip}" ]; then
        echo -e "${R}[!] Download failed. Check internet connection.${RS}"
        sleep 2
        font_menu
        return
    fi
    echo -e "${Y}[*] Extracting ${font_name}...${RS}"
    local extract_dir="$HOME/.termux/temp_extract"
    rm -rf "$extract_dir"
    mkdir -p "$extract_dir"
    
    unzip -o -q "${temp_zip}" "*.ttf" -d "$extract_dir"
    
    local font_files=()
    while IFS= read -r line; do
        [ -n "$line" ] && font_files+=("$line")
    done < <(find "$extract_dir" -type f -name "*.ttf" | sort)
    
    local num_files=${#font_files[@]}
    if [ $num_files -eq 0 ]; then
        echo -e "${R}[!] Could not find any ttf files inside font zip.${RS}"
        rm -rf "$extract_dir"
        rm -f "${temp_zip}"
        sleep 2
        font_menu
        return
    fi
    
    local chosen_font=""
    if [ $num_files -eq 1 ]; then
        chosen_font="${font_files[0]}"
    else
        banner
        printf "\n${left_pad}${C}───[${W} Select Font Variant (${font_name}) ${C}]───\n"
        local idx=1
        for f in "${font_files[@]}"; do
            local name=$(basename "$f")
            printf "\n${left_pad}${C}[${W}%02d${C}]${G} %s" $idx "$name"
            idx=$((idx + 1))
        done
        printf "\n\n${left_pad}${C}Selection (Default: 1): ${RS}"
        read variant_sel
        [ -z "$variant_sel" ] && variant_sel=1
        
        if ! [[ "$variant_sel" =~ ^[0-9]+$ ]] || [ "$variant_sel" -lt 1 ] || [ "$variant_sel" -gt $num_files ]; then
            variant_sel=1
        fi
        chosen_font="${font_files[$((variant_sel - 1))]}"
    fi
    
    if [ -n "$chosen_font" ] && [ -f "$chosen_font" ]; then
        mv "$chosen_font" "$HOME/.termux/font.ttf"
        rm -rf "$extract_dir"
        rm -f "${temp_zip}"
        if command -v termux-reload-settings &>/dev/null; then
            termux-reload-settings
        fi
        echo -e "${G}[√] ${font_name} variant installed successfully!${RS}"
    else
        echo -e "${R}[!] Selection failed.${RS}"
        rm -rf "$extract_dir"
        rm -f "${temp_zip}"
    fi
    sleep 2
    font_menu
}

# Settings Configurator (`termux.properties` editor)
set_property() {
    local key=$1
    local val=$2
    local file="$HOME/.termux/termux.properties"
    mkdir -p "$HOME/.termux"
    touch "$file"
    sed -i "/^[[:space:]]*${key}[[:space:]]*=/d" "$file"
    echo "${key} = ${val}" >> "$file"
    if command -v termux-reload-settings &>/dev/null; then
        termux-reload-settings
    fi
}

configure_cursor_style() {
    banner
    printf "\n${left_pad}${C}───[${W} Configure Cursor Style ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Underline (Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Block"
    printf "\n${left_pad}${C}[${W}3${C}]${G} Bar\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read style_sel
    case $style_sel in
        2) set_property "terminal-cursor-style" "block" ;;
        3) set_property "terminal-cursor-style" "bar" ;;
        *) set_property "terminal-cursor-style" "underline" ;;
    esac
    echo -e "${G}[√] Cursor style updated!${RS}"
    sleep 1.5
    termux_properties_menu
}

configure_cursor_blink() {
    banner
    printf "\n${left_pad}${C}───[${W} Configure Cursor Blinking ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Enable Blinking (Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Disable Blinking\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read blink_sel
    case $blink_sel in
        2) set_property "terminal-cursor-blink-rate" "0" ;;
        *) set_property "terminal-cursor-blink-rate" "600" ;;
    esac
    echo -e "${G}[√] Cursor blinking updated!${RS}"
    sleep 1.5
    termux_properties_menu
}

configure_extra_keys() {
    banner
    printf "\n${left_pad}${C}───[${W} Configure Extra Keys Presets ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Default (Developer compact)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Full Navigation (Arrows, ESC, TAB, DEL)"
    printf "\n${left_pad}${C}[${W}3${C}]${G} Minimalist Layout"
    printf "\n${left_pad}${C}[${W}4${C}]${G} Hidden / Disabled\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read key_sel
    case $key_sel in
        2) set_property "extra-keys" "[['ESC','TAB','-','/','*','UP','DEL'],['CTRL','ALT','LEFT','DOWN','RIGHT','ENTER','HOME']]" ;;
        3) set_property "extra-keys" "[['ESC','TAB','CTRL','ALT','UP','LEFT','DOWN','RIGHT']]" ;;
        4) set_property "extra-keys" "[]" ;;
        *) set_property "extra-keys" "[['/','ls','\$','~','UP','exit','*'],['ex','CTRL','ENTER','LEFT','DOWN','RIGHT','F2']]" ;;
    esac
    echo -e "${G}[√] Extra keys keyboard preset updated!${RS}"
    sleep 1.5
    termux_properties_menu
}

configure_bell_char() {
    banner
    printf "\n${left_pad}${C}───[${W} Configure Bell Character ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Vibrate on alert (Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Ignore (Silent)"
    printf "\n${left_pad}${C}[${W}3${C}]${G} Beep (Ringtone)\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read bell_sel
    case $bell_sel in
        2) set_property "bell-character" "ignore" ;;
        3) set_property "bell-character" "beep" ;;
        *) set_property "bell-character" "vibrate" ;;
    esac
    echo -e "${G}[√] Bell character setting updated!${RS}"
    sleep 1.5
    termux_properties_menu
}

configure_fullscreen() {
    banner
    printf "\n${left_pad}${C}───[${W} Configure Fullscreen Mode ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Normal Screen (Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Fullscreen at Startup\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read fs_sel
    case $fs_sel in
        2) set_property "fullscreen" "true" ;;
        *) set_property "fullscreen" "false" ;;
    esac
    echo -e "${G}[√] Fullscreen launch setting updated!${RS}"
    sleep 1.5
    termux_properties_menu
}

configure_back_key() {
    banner
    printf "\n${left_pad}${C}───[${W} Configure Back-Key Action ${C}]───"
    printf "\n${left_pad}${C}[${W}1${C}]${G} Escape (Triggers ESC key - Default)"
    printf "\n${left_pad}${C}[${W}2${C}]${G} Back (Normal Android Back action)\n\n"
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read bk_sel
    case $bk_sel in
        2) set_property "back-key" "back" ;;
        *) set_property "back-key" "escape" ;;
    esac
    echo -e "${G}[√] Back-key behavior updated!${RS}"
    sleep 1.5
    termux_properties_menu
}

termux_properties_menu() {
    banner
    printf "\n${left_pad}${C}───[${W} Termux Settings & Behavior ${C}]───"
    printf "\n${left_pad}${C}[${W}01${C}]${G} Cursor Style"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Cursor Blinking"
    printf "\n${left_pad}${C}[${W}03${C}]${G} Extra Keys Keyboard Rows"
    printf "\n${left_pad}${C}[${W}04${C}]${G} Bell Character Sound/Vibrate"
    printf "\n${left_pad}${C}[${W}05${C}]${G} Fullscreen Mode"
    printf "\n${left_pad}${C}[${W}06${C}]${G} Back-Key Action"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) configure_cursor_style ;;
        2|02) configure_cursor_blink ;;
        3|03) configure_extra_keys ;;
        4|04) configure_bell_char ;;
        5|05) configure_fullscreen ;;
        6|06) configure_back_key ;;
        0|00) menu ;;
        *) termux_properties_menu ;;
    esac
}

font_menu() {
    banner
    printf "\n${left_pad}${C}───[${W} Termux Nerd Fonts Gallery ${C}]───"
    printf "\n${left_pad}${C}[${W}01${C}]${G} Fira Code Nerd Font"
    printf "\n${left_pad}${C}[${W}02${C}]${G} JetBrains Mono Nerd Font"
    printf "\n${left_pad}${C}[${W}03${C}]${G} Hack Nerd Font"
    printf "\n${left_pad}${C}[${W}04${C}]${G} Caskaydia Cove Nerd Font (Cascadia Code)"
    printf "\n${left_pad}${C}[${W}05${C}]${G} Sauce Code Pro Nerd Font (Source Code Pro)"
    printf "\n${left_pad}${C}[${W}06${C}]${G} Ubuntu Nerd Font"
    printf "\n${left_pad}${C}[${W}07${C}]${G} Meslo Nerd Font"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_install_font "FiraCode.zip" "Fira Code" ;;
        2|02) do_install_font "JetBrainsMono.zip" "JetBrains Mono" ;;
        3|03) do_install_font "Hack.zip" "Hack" ;;
        4|04) do_install_font "CascadiaCode.zip" "Caskaydia Cove" ;;
        5|05) do_install_font "SourceCodePro.zip" "Sauce Code Pro" ;;
        6|06) do_install_font "Ubuntu.zip" "Ubuntu" ;;
        7|07) do_install_font "Meslo.zip" "Meslo" ;;
        0|00) menu ;;
        *) font_menu ;;
    esac
}

# Updates and Security Settings
do_add_lock() {
    echo -e "\n${C}Initialising Security Protocol...${RS}"
    echo -ne "${Y}Create Access Key: ${RS}"
    read -s new_pass
    echo
    
    new_pass_hash=$(echo -n "$new_pass" | sha256sum | cut -d' ' -f1)
    
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
    read -P \"${Y} [Attempt \$attempt/3] Enter Key: ${RS}\" -s pass_input
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
    system_menu
}

do_remove_lock() {
    sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.bashrc
    [ -f ~/.zshrc ] && sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.zshrc
    [ -f ~/.config/fish/config.fish ] && sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.config/fish/config.fish
    echo -e "${R}Security Protocol Deactivated.${RS}"
    sleep 2
    system_menu
}

do_update() {
    banner
    echo -e "${Y}[*] Checking for updates from repository...${RS}"
    git -C "$REPO_DIR" fetch origin
    local LOCAL_COMMIT=$(git -C "$REPO_DIR" rev-parse HEAD)
    local REMOTE_COMMIT=$(git -C "$REPO_DIR" rev-parse "origin/master" 2>/dev/null || git -C "$REPO_DIR" rev-parse "origin/main")
    if [ "$LOCAL_COMMIT" = "$REMOTE_COMMIT" ]; then
        echo -e "${G}[√] You are already on the latest version.${RS}"
        sleep 2
        system_menu
    else
        echo -e "${Y}[*] Updating repository to latest commit...${RS}"
        git -C "$REPO_DIR" pull
        if [ $? -eq 0 ]; then
            echo -e "${G}[√] Update completed successfully! Reloading script...${RS}"
            sleep 2
            exec bash "$REPO_DIR/os.sh"
        else
            echo -e "${R}[!] Update failed. Please check network/git.${RS}"
            sleep 2
            system_menu
        fi
    fi
}

check_for_updates() {
    local DIR="$REPO_DIR"
    local branch
    local FETCH_STATUS
    local LOCAL_COMMIT
    local REMOTE_COMMIT

    [ ! -d "$DIR/.git" ] && return

    branch=$(git -C "$DIR" branch --show-current)

    echo -ne "${Y}[...]${RS} Checking for updates..."

    if command -v timeout >/dev/null 2>&1; then
        timeout 3 git -C "$DIR" fetch origin "$branch" >/dev/null 2>&1
        FETCH_STATUS=$?
    else
        git -C "$DIR" fetch origin "$branch" >/dev/null 2>&1
        FETCH_STATUS=$?
    fi

    if [ $FETCH_STATUS -ne 0 ]; then
        echo -e "\r${Y}[!]${RS} Update check skipped (offline)"
        sleep 1
        echo -ne "\r\033[K"
        return
    fi

    LOCAL_COMMIT=$(git -C "$DIR" rev-parse HEAD)
    REMOTE_COMMIT=$(git -C "$DIR" rev-parse "origin/$branch")

    if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ] &&
       git -C "$DIR" merge-base --is-ancestor "$LOCAL_COMMIT" "$REMOTE_COMMIT"; then

        echo -e "\r${G}[!]${RS} A new version is available!"
        echo -e "    Local  version: ${Y}${LOCAL_COMMIT:0:7}${RS}"
        echo -e "    Latest version: ${G}${REMOTE_COMMIT:0:7}${RS}"
        echo

        echo -ne "${C}[?]${RS} Update now? (y/N): "
        read -r auto_update

        if [[ "$auto_update" =~ ^[yY]$ ]]; then
            git -C "$DIR" pull origin "$branch"
            if [ $? -eq 0 ]; then
                echo -e "${G}[√] Update completed successfully! Reloading script...${RS}"
                sleep 2
                exec bash "$DIR/os.sh"
            else
                echo -e "${R}[!] Update failed. Please check network/git.${RS}"
                sleep 2
            fi
        fi
        return
    fi
    echo -ne "\r\033[K"
}

# Color Theme Installer Engine
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

# Sub-menus
zsh_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Full Zsh Setup (Oh My Zsh + Custom Theme)"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Switch to Zsh Shell"
    printf "\n${left_pad}${C}[${W}03${C}]${Y} Customize Prompt & Welcome Banner"
    printf "\n${left_pad}${C}───"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_zsh_setup ;;
        2|02) do_zsh_switch ;;
        3|03) do_customize_prompts_menu "zsh" ;;
        0|00) menu ;;
        *) zsh_menu ;;
    esac
}

bash_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Full Bash Setup (ble.sh + Custom Theme)"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Switch to Bash Shell"
    printf "\n${left_pad}${C}[${W}03${C}]${Y} Customize Prompt & Welcome Banner"
    printf "\n${left_pad}${C}───"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_bash_setup ;;
        2|02) do_bash_switch ;;
        3|03) do_customize_prompts_menu "bash" ;;
        0|00) menu ;;
        *) bash_menu ;;
    esac
}

fish_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Full Fish Setup (config + Custom Theme)"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Switch to Fish Shell"
    printf "\n${left_pad}${C}[${W}03${C}]${Y} Customize Prompt & Welcome Banner"
    printf "\n${left_pad}${C}───"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_fish_setup ;;
        2|02) do_fish_switch ;;
        3|03) do_customize_prompts_menu "fish" ;;
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
    printf "\n${left_pad}${C}[${W}06${C}]${G} Gruvbox Theme"
    printf "\n${left_pad}${C}[${W}07${C}]${G} Tokyo Night Theme"
    printf "\n${left_pad}${C}[${W}08${C}]${G} Catppuccin Theme"
    printf "\n${left_pad}${C}[${W}09${C}]${G} Ayu Dark Theme"
    printf "\n${left_pad}${C}[${W}10${C}]${G} Cobalt2 Theme"
    printf "\n${left_pad}${C}[${W}11${C}]${G} One Half Dark Theme"
    printf "\n${left_pad}${C}───"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_set_theme "default" ;;
        2|02) do_set_theme "dracula" ;;
        3|03) do_set_theme "nord" ;;
        4|04) do_set_theme "monokai" ;;
        5|05) do_set_theme "solarized" ;;
        6|06) do_set_theme "gruvbox" ;;
        7|07) do_set_theme "tokyonight" ;;
        8|08) do_set_theme "catppuccin" ;;
        9|09) do_set_theme "ayu" ;;
        10) do_set_theme "cobalt2" ;;
        11) do_set_theme "onehalf" ;;
        0|00) menu ;;
        *) color_theme_menu ;;
    esac
}

menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Necessary Setup"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Zsh Customizer"
    printf "\n${left_pad}${C}[${W}03${C}]${G} Fish Customizer"
    printf "\n${left_pad}${C}[${W}04${C}]${G} Bash Customizer"
    printf "\n${left_pad}${C}[${W}05${C}]${B} Termux Nerd Fonts"
    printf "\n${left_pad}${C}[${W}06${C}]${Y} Termux Color Themes"
    printf "\n${left_pad}${C}[${W}07${C}]${C} Termux Behavior Settings"
    printf "\n${left_pad}${C}[${W}08${C}]${W} Security & Updates"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Exit Terminal\n\n"
    
    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_full_setup ;;
        2|02) zsh_menu ;;
        3|03) fish_menu ;;
        4|04) bash_menu ;;
        5|05) font_menu ;;
        6|06) color_theme_menu ;;
        7|07) termux_properties_menu ;;
        8|08) system_menu ;;
        0|00) exit ;;
        *) menu ;;
    esac
}

check_for_updates
menu
