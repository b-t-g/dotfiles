alias ff="firefox"
bindkey -e
export EDITOR=vim
alias sn="sudo shutdown now -hP"
#alias agi="sudo aptitude install"
#alias ai="sudo aptitude install"
#alias agd="sudo apt-get update"
#alias agg="sudo apt-get upgrade"
alias python="python3"
#alias z="alsamixer"
#alias agup='sudo apt-get update && sudo apt-get upgrade'
alias a='ls -FG'
#alias pdfopen='pdfopen -viewer evince'
alias weechat='weechat-curses'
alias rlang='R'
#alias matlab='/home/brendan/matlab/bin/matlab'
#alias apti='sudo aptitude update && sudo aptitude safe-upgrade'
alias please='eval "sudo $(fc -ln -1)"'
alias emacs='emacs -nw'
alias ocaml='rlwrap ocaml'
alias rogue='qjoypad --device /dev/input/js0 Rogue'
#zle -N zle-line-init
#zle -N zle-keymap-select
export SWT_GTK3=0
alias ctags="/usr/local/bin/ctags"
cs=~/pdfs/cs/
C=~/code/C
haskell=~/code/haskell
: ~cs ~C ~haskell
#export PATH=$PATH:$HOME/neovim/bin:usr/lib/jvm/java-7-openjdk-amd64/bin/:usr/lib/jvm/java-7-openjdk-amd64/bin:$HOME/idea-IC-143.1184.17/bin:$HOME/java-mars/eclipse/:$HOME/.local/bin:$HOME/Downloads/Telegram:$HOME/.cabal/bin

function hide {
    mv $1 $(echo $1 | awk '{gsub(/^/, "."); print}')
}

function unhide {
    mv $1 $(echo $1 | awk '{gsub(/^./, ""); print}')
}
