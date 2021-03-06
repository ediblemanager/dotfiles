# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
if [ -f /etc/bashrc ]; then
        ./etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend                       # append history file
export PROMPT_COMMAND="history -a"        # update histfile after every command

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

umask 0007

BLUE="\001\e[0;34m\002"
BOLDBLUE="\001\e[1;34m\002"
CYAN="\001\e[0;36m\002"
BOLDCYAN="\001\e[1;36m\002"
GREEN="\001\e[0;32m\002"
BOLDGREEN="\001\e[1;32m\002"
RED="\001\e[0;31m\002"
LIGHTRED="\001\e[1;31m\002"
MAGENTA="\001\e[0;35m\002"
RESET="\001\e[0m\002"
BOLDYELLOW="\001\e[1;33m\002"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Colors in terminal!
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

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

unset color_prompt force_color_prompt
export RUBY_GC_HEAP_INIT_SLOTS=800000
export RUBY_HEAP_FREE_MIN=100000
export RUBY_HEAP_SLOTS_INCREMENT=300000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=79000000

set_bash_prompt ()
{
	# setup git status for bash prompt
    git_status="$(git status 2> /dev/null)"

    if [[ ${git_status} =~ "working directory clean" ]]; then
        state=${GREEN} # Green
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
        state=${BOLDYELLOW} # Yellow
    else
        state=${LIGHTRED} # Red
    fi

	TITLEBAR='\[\e]0;\u@\h - \w\a\]'
	PS1="${TITLEBAR}[${BOLDGREEN}\u${RESET}@${CYAN}\h${RESET} \W${state}\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/[\1]/')${RESET}]\$ "

	unset git_status

}

PROMPT_COMMAND=set_bash_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -lh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Always compress scp transfers
alias scp='scp -C'

# Essential: will allow you to edit and then reload bashrc
alias bashrc='vim ~/.bashrc && source ~/.bashrc'

# Stop accidentally using vi
alias vi='vim'
alias cim='vim'

# Nice way of viewing the total size for folders
alias folder_size='du -cksh .[!.]* *'

# Clean up everything laravel-based.
alias clean_up='php artisan dump-autoload && php artisan clear-compiled && composer dumpautoload -o'

# Alias to: update composer, chmod to allow me access, update the repo
alias comp_update='sudo composer selfupdate && sudo chown gordon /usr/local/bin/composer && composer update'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Check repo name
alias repo_name="git remote -v 2> /dev/null | head -n1 | awk '{print \$2}' | sed 's/.*\///;s/.*\://;s/\.git//'"

# PHPUnit alias
alias phpunit='`pwd`/vendor/phpunit/phpunit/phpunit'

# PHPUnit alias for logging test results
alias phpunit_log='phpunit --log-junit log.junit.xml'

# phing alias
alias phing='sudo phing && sudo chown -R gordon app/tests/results && cp -R app/tests/results ~/git_projects'

alias testcode='phpunit_log && phing'

# Use VIM for less colouring and highlighting.
alias vless='vim -u /usr/share/vim/vim73/macros/less.vim -'

# Alias for easy upgrade
alias upgrade='sudo apt-get update && sudo apt-get upgrade'

# Restart shell as login shell
alias restart_shell='exec $SHELL -1'

# Alias 'sudo' so that you can sudo alias'...
alias sudo='sudo '

# Scan network for devices
alias scan_network='nmap -sP  192.168.0.1-254 --system-dns'

# Find external IP
alias external_ip='wget ifconfig.me'

# Update and Upgrade the system
alias upgrade='apt-get update && sudo apt-get dist-upgrade'

# This might seem like a weird one, but for editing migrations in Laravel - godsend!
# Regex probably would be better here, but I've not learned that black art properly.
alias find_migs='find . -name "*_*_*_*_*_*_*_*"'

# Deploy from git
alias dfg='~/bin/deploy_from_git/deploy_from_git.sh'

# Alias to handle the reloading of the font cache
alias reload_fonts='sudo fc-cache -f -v'

# Check to see if the system needs reboot
alias check_reboot='cat /var/run/reboot-required'

function port_owners() {
    sudo netstat -tulpn
}

# find all files within folders matching patter, run ls on them
function find_and_list() {
    find "$1" -name "$2" -exec ls -l {} \;
}

# Fix folder perms
function folder_perms() {
    find "$1" -type d -exec chmod 2755 {} \;
}

# Fix file perms
function file_perms() {
    find "$1" -type f -exec chmod 660 {} \;
}

# Find and replace spaces in DIR's and Filenames.
function remove_spaces() {
	find "$1" -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;
}

# Spell checking on the prompt
shopt -s cdspell

function parse_git_branch {
  #ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  ref=$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/') || return
  echo "["${ref#refs/heads/}"]"
}

function monitor_laptop_large() {
    xrandr --newmode "1680x1050_60.00"  147.14  1680 1784 1968 2256  1050 1051 1054 1087 > /dev/null 2>&1
    xrandr --addmode VBOX0 1680x1050_60.00
    xrandr --output VBOX0 --mode 1680x1050_60.00
}

function monitor_laptop_retina() {
    xrandr --newmode "1440x900_60.00"  106.47  1440 1520 1672 1904  900 901 904 932 > /dev/null 2>&1
    xrandr --addmode VBOX0 1440x900_60.00
    xrandr --output VBOX0 --mode 1440x900_60.00
}

function monitor_work_external() {
    xrandr --newmode "1920x1180_60.00"  189.89  1920 2048 2256 2592  1180 1181 1184 1221 > /dev/null 2>&1
    xrandr --addmode VBOX0 1920x1180_60.00
    xrandr --output VBOX0 --mode 1920x1180_60.00
}

function monitor_home_external() {
    xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 > /dev/null 2>&1
    xrandr --addmode VBOX0 1920x1080_60.00
    xrandr --output VBOX0 --mode 1920x1080_60.00
}

# Fixes for RVM to work properly: a login shell is needed, so we're hacking here to ensure it works regardless.
if test -f ~/.rvm/scripts/rvm; then
    [ "$(type -t rvm)" = "function" ] || source ~/.rvm/scripts/rvm
fi

function _update_ps1() {
    export PS1="$(~/bin/powerline-shell.py $? 2> /dev/null)"
}
export PROMPT_COMMAND="_update_ps1"

#PROMPT_COMMAND=set_bash_prompt
unset command_not_found_handle
export EDITOR='vim'
export PATH=$PATH:/home/gordon/projects/capod/laravel_sumac/vendor/bin
# Add ~/.local/bin for pip installed user binaries
export PATH=$PATH:/home/gordon/.local/bin

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
