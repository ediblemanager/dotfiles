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
export TERM=xterm-256color

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

# VI commands in bash, but *only* in bash
set -o vi
bind -m vi-command ".":insert-last-argument
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep="`which grep` --color=auto"
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias grep="`which grep` --color=auto"

# some more ls aliases
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'
alias lh='ls -lhG'

# Always compress scp transfers
alias scp='scp -C'

# Essential: will allow you to edit and then reload bashrc
alias bashrc='vim ~/.bash_profile && source ~/.bash_profile'

# Stop accidentally using vi
alias vi='nvim'
alias cim='nvim'
alias vim='nvim'

# Nice way of viewing the total size for folders
alias folder_size='du -cksh .[!.]* *'

# Clean up everything laravel-based.
alias clean_up='composer dump-autoload && php artisan clear-compiled && php artisan cache:clear && php artisan view:clear && php artisan config:cache'
# Show latest commits
alias show_me="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# Diff last two commits
alias last_two="git diff $(git log --pretty=format:%h -2 --reverse | tr "\n" " ")"

# Show every file that's ever been added to a repo
alias every_file="git log --name-status --oneline --all | grep -P \"^[A|M|D]\s\" | awk '{print $2}' | sort | uniq"

# PHPUnit alias
alias phpunit='php `pwd`/vendor/phpunit/phpunit/phpunit'

alias paratest='php `pwd`/vendor/bin/paratest -p4 --colors'

# PHPUnit alias for logging test results
alias phpunit_log='phpunit --log-junit log.junit.xml'

# Use VIM for less colouring and highlighting.
alias vless='vim -u /usr/share/vim/vim73/macros/less.vim -'

# Alias 'sudo' so that you can sudo alias'...
alias sudo='sudo '

# Scan network for devices
alias scan_network='nmap -sP  192.168.0.1-254 --system-dns'

# Find external IP
alias external_ip='wget ifconfig.me'

# This might seem like a weird one, but for editing migrations in Laravel - godsend!
# Regex probably would be better here, but I've not learned that black art properly.
alias find_migs='find . -name "*_*_*_*_*_*_*_*"'

# Deploy from git
alias dfg='~/bin/deploy_from_git/deploy_from_git.sh'

# Clear all the laravel things
alias artisan_clear='php artisan cache:clear && php artisan config:clear && php artisan route:clear && php artisan view:clear'

# Reset session
alias reset_session='exec -l $SHELL'

# Connect to Homestead DB
alias homestead_db='mysql -u homestead -p --host=127.0.0.1 --port=33060'

# Laradock aliases
function laradock() {
    ( cd ~/code/local-dev-docker && docker-compose $* )
}

alias devbash='laradock exec workspace bash'
alias devup='laradock up -d nginx mariadb workspace'
alias devdown='laradock down'
alias laradock_db="docker exec -t -i laradock_mariadb_1 mysql -udefault -p"

function laradock_artisan() {
    # $1 is container name
    # $2 is command to run in bash
    docker exec -t -i $1 /bin/bash -c "$2"
}

function homestead_artisan() {
    cd ~/Homestead && vagrant ssh -c "cd ~/code/$1 && ls -la && hostname && php artisan $2 && exit"; cd ~/Documents/sumac/vm_code/$1;
}

# Spell checking on the prompt
shopt -s cdspell

# Functions

# Check for massive files (over 1gb). Not doing this on / would be sensible...but meh!
function huge_files() {
    du -h "$1" | grep '[0-9\.]\+G'
}

function port_owners() {
    sudo netstat -tulpn
}

# find all files within folders matching patter, run ls on them
function find_and_list() {
    find "$1" -name "$2" -exec ls -l {} \;
}

# Fix folder perms
function folder_perms() {
    find "$1" -type d -exec chmod 2775 {} \;
}

# Fix file perms
function file_perms() {
    find "$1" -type f -exec chmod 660 {} \;
}

# Find and replace spaces in DIR's and Filenames.
function remove_spaces() {
	find "$1" -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;
}

# Run Homestead
function homestead() {
	( cd ~/Homestead && vagrant $* )
}

# Get the weather for dundee
function weather() {
    curl "http://wttr.in/$1?lang=gb"
}
function moon() {
    curl "http://wttr.in/moon"
}

# b-ryan powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

# Sort out tab completion
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#. $(brew --prefix)/etc/bash_completion
#fi

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if type brew &>/dev/null; then
    for COMPLETION in $(brew --prefix)/etc/bash_completion.d/*
    do
        [[ -f $COMPLETION ]] && source "$COMPLETION"
    done
    if [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]];
    then
        source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi
fi

export PATH=~/.yarn/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"
