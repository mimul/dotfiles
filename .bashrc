#       ___           ___           ___           ___           ___           ___      
#      /\  \         /\  \         /\  \         /\__\         /\  \         /\  \     
#     /::\  \       /::\  \       /::\  \       /:/  /        /::\  \       /::\  \    
#    /:/\:\  \     /:/\:\  \     /:/\ \  \     /:/__/        /:/\:\  \     /:/\:\  \   
#   /::\~\:\__\   /::\~\:\  \   _\:\~\ \  \   /::\  \ ___   /::\~\:\  \   /:/  \:\  \  
#  /:/\:\ \:|__| /:/\:\ \:\__\ /\ \:\ \ \__\ /:/\:\  /\__\ /:/\:\ \:\__\ /:/__/ \:\__\ 
#  \:\~\:\/:/  / \/__\:\/:/  / \:\ \:\ \/__/ \/__\:\/:/  / \/_|::\/:/  / \:\  \  \/__/ 
#   \:\ \::/  /       \::/  /   \:\ \:\__\        \::/  /     |:|::/  /   \:\  \       
#    \:\/:/  /        /:/  /     \:\/:/  /        /:/  /      |:|\/__/     \:\  \      
#     \::/__/        /:/  /       \::/  /        /:/  /       |:|  |        \:\__\     
#      ~~            \/__/         \/__/         \/__/         \|__|         \/__/     
#                                                                                      

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export PAGER=less
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
export LESS='-f -N -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESS='-f -X -i -P ?f%f:(stdin). ?lb%lb?L/%L.. [?eEOF:?pb%pb\%..]'
export LESSCHARSET='utf-8'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export MYHISTFILE=~/.bash_myhistory

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------
# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.

# Normal Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

NC="\033[m"               # Color Reset
CR="$(echo -ne '\r')"
LF="$(echo -ne '\n')"
TAB="$(echo -ne '\t')"
ESC="$(echo -ne '\033')"

ALERT=${BWhite}${On_Red} # Bold White on red background

bash_exit() { #{{{1
    HISTSIZE=50000
    HISTFILESIZE=50000

    show_exit() {
        if [ "$1" -eq 0 ]; then return; fi
        echo -e "\007exit $1"
    }

    log_history() {
        echo "$(date '+%Y-%m-%d %H:%M:%S') $HOSTNAME:$$ $PWD ($1) $(history 1)" >> $MYHISTFILE
    }

    prompt_cmd() {
        local s=$?
        show_exit $s;
        log_history $s;
    }

    end_history() {
        log_history $?;
        echo "$(date '+%Y-%m-%d %H:%M:%S') $HOSTNAME:$$ $PWD (end)" >> $MYHISTFILE
    }
    PROMPT_COMMAND="prompt_cmd;$PROMPT_COMMAND"

    _exit() {
        end_history
        echo -e  "${BRed}Hasta la vista, baby!"
        echo -en "\033[m"
    }
    trap _exit EXIT
}

bash_zshlike() {
    shopt -s globstar
    #shopt -s dotglob
    shopt -s extglob
    shopt -s cdspell
    shopt -s autocd
    shopt -s cdspell
}

bash_loading() { #{{{1
    if [ -d ~/.loading ]; then
        . ~/.loading/*.sh
    fi

    [ -f /etc/bash_completion ]     && . /etc/bash_completion
    [ -f /etc/git-completion.bash ] && . /etc/git-completion.bash
    [ -f /etc/git-prompt.bash ]     && . /etc/git-prompt.bash
}

bash_at_startup() { #{{{1
    echo -e "${BCyan}This is BASH ${BRed}${BASH_VERSION%.*}${BCyan} - DISPLAY on ${BRed}$DISPLAY${NC}\n"
    echo "$(date '+%Y-%m-%d %H:%M:%S') $HOSTNAME:$$ $PWD (start)" >> $MYHISTFILE

    bash_loading

    #cowsay -f ghostbusters "$(fortune -s)"
    echo
}

if bash_at_startup; then
    PS1="[${Yellow}\u${NC}]:${Blue}\w${NC}\$ "
    export PS1
fi

# __END__{{{1
# vim:fdm=marker fdc=3 ft=sh ts=4 sw=4 sts=4:
