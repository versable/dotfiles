export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="kafeitu"

plugins=(git svn dircycle)

source $ZSH/oh-my-zsh.sh

alias dirs="dirs -v"
alias tmux="tmux -2"

# Use 256 colors in the terminal
export TERM=xterm-256color

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Colored man pages: http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;016m\E[48;5;220m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

