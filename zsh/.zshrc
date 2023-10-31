# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git python ssh-agent)

source $ZSH/oh-my-zsh.sh

# Aliases
alias bottles-cli="flatpak run --command=bottles-cli com.usebottles.bottles"
alias battlenet="bottles-cli run -b WoW -p Battle.net"
alias wowup="~/appimages/wowup/AppRun"
alias raiderio="~/appimages/raiderio/AppRun"
alias warcraftlogs="~/appimages/warcraftlogs/AppRun"
