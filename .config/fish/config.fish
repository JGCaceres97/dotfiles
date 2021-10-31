set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias grep "grep --color=auto"
alias ls "ls --color=auto"

alias cp "cp -i"
alias df "df -h"
alias free "free -m"

alias .. "cd .."
alias alacrittycfg "mousepad ~/.config/alacritty/alacritty.yml"
alias fishcfg "mousepad ~/.config/fish/config.fish"
alias install "yay -S"
alias pacmancache "sudo pacman -Scc"
alias removedeps "yay -Rsnc (yay -Qtdq)"
alias uninstall "yay -Rsn"
alias search "yay -Ss"
alias starshipcfg "mousepad ~/.config/starship.toml"
alias update "yay -Syu"
alias yaycache "yay -Scc"

# Prompt
starship init fish | source
