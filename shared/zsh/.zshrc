# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git python ssh-agent)

source $ZSH/oh-my-zsh.sh

if command -v nvim &> /dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# Aliases
alias bottles-cli="flatpak run --command=bottles-cli com.usebottles.bottles"
alias battlenet="bottles-cli run -b WoW -p Battle.net"
alias udasd="sudo paccache -r && sudo pacman -Syu && sudo shutdown now"
alias av="source .venv/bin/activate"
alias make-dark="xrandr --output HDMI-A-0 --brightness 0.8 --output DisplayPort-2 --brightness 0.8"
alias make-darker="xrandr --output HDMI-A-0 --brightness 0.6 --output DisplayPort-2 --brightness 0.8"
alias make-light="xrandr --output HDMI-A-0 --brightness 1 --output DisplayPort-2 --brightness 1"
alias :q="exit"
alias cf="caffeine"
alias copy="xclip -selection clipboard"
alias sz="source ~/.zshrc"
alias protontricks='flatpak run com.github.Matoking.protontricks'
alias protontricks-launch='flatpak run --command=protontricks-launch com.github.Matoking.protontricks'
alias cdwow="cd .var/app/com.usebottles.bottles/data/bottles/bottles/WoW/drive_c/Program\ Files\ \(x86\)/World\ of\ Warcraft/_retail_/"
alias spotify='spotify-launcher --skip-update'
