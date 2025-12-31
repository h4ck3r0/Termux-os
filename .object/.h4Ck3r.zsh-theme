autoload -U colors && colors
setopt prompt_subst

function parse_git_status() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo " %{$fg_bold[red]%}(${branch}*)%{$reset_color%}"
    else
        echo " %{$fg_bold[green]%}(${branch})%{$reset_color%}"
    fi
}

local user_info="%{$fg_bold[red]%}[%{$fg_bold[green]%}H4ck3r%{$fg_bold[red]%}@%{$fg_bold[white]%}termux%{$fg_bold[red]%}]"
local current_dir="%{$fg_bold[red]%}[%{$fg_bold[cyan]%}%(5~|%-1~/…/%2~|%4~)%{$fg_bold[red]%}]"
local git_info='$(parse_git_status)'
local status_arrow="%(?.%{$fg_bold[green]%}❯❯❯.%{$fg_bold[red]%}❯❯❯)"

PROMPT="
%{$fg_bold[red]%}┌─${user_info}─${current_dir}${git_info}
%{$fg_bold[red]%}└─╼ ${status_arrow} %{$reset_color%}"
