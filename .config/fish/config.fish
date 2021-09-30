set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias grep "grep --color=auto"
alias ls "ls --color=auto"

alias cp "cp -i"
alias df "df -h"
alias free "free -m"

alias cfgcritty "mousepad ~/.config/alacritty/alacritty.yml"
alias fishcfg "mousepad ~/.config/fish/config.fish"
alias starshipcfg "mousepad ~/.config/starship.toml"

# Prompt
starship init fish | source
