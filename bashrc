# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export HISTCONTROL=ignoreboth:ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                              # big big history
export HISTFILESIZE=100000                          # big big history
shopt -s histappend                                 # append to history, don't
                                                    # overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    screen-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]  '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Set printer defaults
alias lp="lp -o media=a4"

# Use vim as super user with the users local .vimrc
alias suvim='sudo -E vim'
alias vim='vim'

# Clipboard alias
alias xclip='xclip -selection clipboard'

# Sppedtest
alias speedtest='wget -O /dev/null http://speedtest.belwue.net/10G --report-speed=bits'

# Wireguard
alias wgu='wg-quick up wg0'
alias wgd='wg-quick down wg0'

# Mutt/Neomutt
alias mutt='neomutt'

# Dual monitor setup
alias dualmon="xrandr --auto --output DP-3-1 --primary --mode 2560x1440 --right-of eDP-1 && killall plank && plank&"

# Simple function to copy local bashrc to remote, resolves symlinks and is
# similar to ssh-copy-id in usage.
function ssh-copy-bashrc {
    rsync -ahP --copy-links ~/.bashrc "$1":
}

function wgs {
    ip addr show dev wg0 2>/dev/null | awk \
        '{
            if ($1 == "inet") {
                wgs = $2;
            }
        } END {
            if (wgs) {
                print "wg0 is up with " wgs;
                exit 0
            } else {
                print "wg0 is down";
                exit 1;
            }
        }'
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

export EDITOR="vim"
export VISUAL="vim"
export TERM="screen-256color"

# Tput color codes
# Foreground
TPUT_FG_BLACK=`tput setaf 0`
TPUT_FG_BLUE=`tput setaf 1`
TPUT_FG_GREEN=`tput setaf 2`
TPUT_FG_CYAN=`tput setaf 3`
TPUT_FG_RED=`tput setaf 4`
TPUT_FG_MAGENTA=`tput setaf 5`
TPUT_FG_YELLOW=`tput setaf 6`
TPUT_FG_WHITE=`tput setaf 7`

# Background
TPUT_BG_BLACK=`tput setab 0`
TPUT_BG_BLUE=`tput setab 1`
TPUT_BG_GREEN=`tput setab 2`
TPUT_BG_CYAN=`tput setab 3`
TPUT_BG_RED=`tput setab 4`
TPUT_BG_MAGENTA=`tput setab 5`
TPUT_BG_YELLOW=`tput setab 6`
TPUT_BG_WHITE=`tput setab 7`

# Special
TPUT_BOLD=`tput bold`
TPUT_BLINK=`tput blink`
TPUT_INVERSE=`tput rev`
TPUT_UNDERLINE=`tput smul`
TPUT_RESET=`tput sgr0`

# Less colors for man pages
export LESS_TERMCAP_mb=$"$TPUT_BLINK"                 # begin blinking
export LESS_TERMCAP_md=$"$TPUT_BOLD$TPUT_FG_RED"      # begin bold
export LESS_TERMCAP_me=$"$TPUT_RESET"                 # end mode
export LESS_TERMCAP_so=$"$TPUT_BG_CYAN$TPUT_FG_BLACK" # begin standout-mode
export LESS_TERMCAP_se=$"$TPUT_RESET"                 # end standout-mode
export LESS_TERMCAP_us=$"$TPUT_UNDERLINE$TPUT_RED"    # begin underline
export LESS_TERMCAP_ue=$"$TPUT_RESET"                 # end underline

# For perlomni
export PATH=~/.vim/bin:$PATH
export PATH=~/.cargo/bin:$PATH

# Set user bin path
export PATH="$PATH:/home/mlangfe/.local/bin"
