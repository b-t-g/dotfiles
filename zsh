alias ff="firefox"
bindkey -e
export EDITOR=emacsclient
alias sn="sudo shutdown now -hP"
#alias agi="sudo aptitude install"
#alias ai="sudo aptitude install"
#alias agd="sudo apt-get update"
#alias agg="sudo apt-get upgrade"
alias python="python3"
alias ocaml="rlwrap ocaml"
#alias z="alsamixer"
#alias agup='sudo apt-get update && sudo apt-get upgrade'
alias a='ls -FG'
#alias pdfopen='pdfopen -viewer evince'
alias weechat='weechat-curses'
alias rlang='R'
#alias matlab='/home/brendan/matlab/bin/matlab'
#alias apti='sudo aptitude update && sudo aptitude safe-upgrade'
alias grr='pkill -9 cmus'
alias please='eval "sudo $(fc -ln -1)"'
alias temacs='emacs -nw'
alias rogue='qjoypad --device /dev/input/js0 Rogue'
alias c='clear'
alias hack="curl -L news.ycombinator.com | tr '<' '\n' | awk -F '\"' 'BEGIN{last = \"\"}/storylink/ {gsub(/ rel=\".+\">/, \"\"); gsub(/>/, \"\"); story=\$5} /http/{ if(story != last) {print story \": \" \$2; last = story}}'"
#zle -N zle-line-init
#zle -N zle-keymap-select
export SWT_GTK3=0
alias ctags="/usr/local/bin/ctags"
cs=~/pdfs/cs/
C=~/code/C
haskell=~/code/haskell
: ~cs ~C ~haskell
#export PATH=$PATH:$HOME/neovim/bin:usr/lib/jvm/java-7-openjdk-amd64/bin/:usr/lib/jvm/java-7-openjdk-amd64/bin:$HOME/idea-IC-143.1184.17/bin:$HOME/java-mars/eclipse/:$HOME/.local/bin:$HOME/Downloads/Telegram:$HOME/.cabal/bin
export PATH=$PATH:/Users/brendangood/.local/bin:/Users/brendangood/go/bin

function hide {
    mv $1 $(echo $1 | awk '{gsub(/^/, "."); print}')
}

function unhide {
    mv $1 $(echo $1 | awk '{gsub(/^./, ""); print}')
}

function dez {
    pkill -9 $1
}

function ncal {
    cal $1 $(date +%Y)
}
export WORKON_HOME=~/Envs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
