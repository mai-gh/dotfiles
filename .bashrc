#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export EDITOR=vim
#export PAGER=less
export PAGER=vimpager
export MANPAGER='vim -M +MANPAGER "+set nonumber" -'



PATH="$HOME/scripts:$PATH"

alias gh='DAY=$(date +%d); \
          MONTH=$(date +%m); \
          WDIR=$HOME/work/gh/$MONTH-$DAY; \
          if [ ! -d $WDIR ]; then \
            mkdir -p $WDIR; \
          fi; \
          cd $WDIR; \
          clear'

alias ls='ls --color=auto -t --reverse -l --all'
alias mc='mc -bd'
PS1='[\u@\h \W]\$ '
