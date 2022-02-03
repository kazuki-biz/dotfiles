# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################### 自分で設定したやつ ###################
export PATH="$HOME/.local/bin/:$PATH"
export PATH=/opt/homebrew/bin:$PATH

# peco
## コマンドの履歴をみるやつ ##
function peco-history-selection() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

## Git リポジトリを選択するやつ ##
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

## エイリアス
alias vim='nvim'

eval "$(anyenv init -)"

export PATH=$PATH:`npm bin -g`
export TERM=xterm-256color
##########################################################

## PC 毎の固有の設定
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# etc
# alias
alias ls='exa'
alias la='exa -a'
alias ll='exa -l'
alias cat='bat' 
alias restart='exec $SHELL -l' 
alias g='cd $(ghq root)/$(ghq list | peco)'
alias sv='ssh $(sh ~/shell/ssh_hosts.sh | peco)'
alias open="open -a '/Applications/Google Chrome.app'"

# alias git
alias pco='git checkout $(git branch | tr \* " " | peco)'
alias pdi='git diff $(git branch | tr \* " " | peco) $(git branch | tr \* " " | peco)'↲
alias ppush='git push origin $(git branch | tr \* " " | peco)'
alias push='git push origin $(git branch --contains | tr \* " ")'
alias ppull='git pull origin $(git branch | tr \* " " | peco)'
alias pull='git pull origin $(git branch --contains | tr \* " ")'
alias pbd='git branch -D $(git branch | tr \* " " | peco)'
alias ci='git commit'
alias st='git status'
alias add='git add'
alias co='git checkout'
alias di='git diff'

# export
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/redis@3.2/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export NODEBREW_ROOT="/usr/local/var/nodebrew"
export PATH="/usr/local/Cellar/go/1.14.2_1/bin:$PATH"
export PATH="/usr/local/Cellar/protobuf/3.11.4_1/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
