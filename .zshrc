# alias
alias ls='ls -G'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -p'
alias ssh='TERM=xterm ssh -A -C'
alias gst='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias diff='colordiff'
alias tmux='tmux -u'
alias -g B='`git branch -a | peco --prompt "GIT BRANCH>" | head -n1 | sed -e "s/^\*\s*//g"`'
alias -g R='`git remote | peco --prompt "GIT REMOTE>" | head -n1`'
alias push='git push R B'
alias pull='git pull R B'
alias hosts='cat /private/etc/hosts | peco'

# env
export EDITOR=vim
export FCEDIT=vim
export PAGER=less
export LESS='-RQM' # R = そのままの制御文字を出力 + 可能なら表示を正しく維持
                   # Q = 完全に quite
                   # M = 詳細なパーセント表示のプロンプト

export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

# LANG
export LANG=ja_JP.UTF-8
export LC_CTYPE=${LANG}

# zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でhistory共有
setopt share_history
setopt no_beep
# 表示ごとにpromptの変数を評価する
setopt prompt_subst
# color表示のための設定
autoload -Uz colors
colors

# zsh incremental completion
source $HOME/.config/zsh/plugins/incr-0.2/incr.zsh

# zsh vcs info more
source $HOME/.config/zsh/plugins/zsh-vcs-prompt/zshrc.sh

# gvm
if [ -e $HOME/.gvm/bin/gvm-init.sh ]; then
  source $HOME/.gvm/bin/gvm-init.sh
fi

# ssh-add
ssh-add

# kerberos
kinit -R
if [ $? -ne 0 ]; then
  kinit --renewable
fi

# setting SPROMPT
setopt correct
SPROMPT="%{$fg[red]%}%{$suggest%}(#꒪﹃꒪) ? < あん? これって %B%r%b %{$fg[red]%}じゃねーの? [いえす!(y), ちゃう!(n), きゃんせる!(a), しぇるに戻る!(e)]:${reset_color} "

# PROMPT
PROMPT='%{$fg[magenta]%}[%c] %{$reset_color%}'
ZSH_VCS_PROMPT_ENABLE_CACHING='true'
RPROMPT='$(vcs_super_info)'
# To activate these completions, add the following to your .zshrc:
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions(N-/) $fpath)
fi

# To activate antigen
if [ -e /usr/local/share/antigen.zsh ]; then
  source /usr/local/share/antigen.zsh
fi


# To activate the syntax highlighting, add the following at the end of your .zshrc:
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# brew-file
# brew-wrap wraps the original brew command for an automatic update of Brewfile when you execute such a brew install or brew uninstall.
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# Add the following to your zshrc to access the online help:
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# emacs keybind
bindkey -e

# Ctrl + S for Vim

stty -ixon -ixoff

# anyenv
# see: https://github.com/riywo/anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# use jenv, so this setting should be written after anyenv.
_JAVA_VERSION=$(jenv version | cut -d' ' -f1)
export JAVA_HOME=$(/usr/libexec/java_home -v ${_JAVA_VERSION})

# cool-peco
# 最近anyframeでもいいような気がしている。。。
# cf. http://sssslide.com/www.slideshare.net/mollifier/anyframe-47698822
source $HOME/.config/peco/plugins/cool-peco/cool-peco
### cool-peco-filename-search
zle -N cool-peco-filename-search
bindkey '^f' cool-peco-filename-search

### cool-peco-ghq
zle -N cool-peco-ghq
bindkey '^g' cool-peco-ghq

### cool-peco-history
alias cph=cool-peco-history
zle -N cool-peco-history
bindkey '^r' cool-peco-history

### cool-peco-ssh
alias s=cool-peco-ssh


#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/takahiro.nakayama/.gvm/bin/gvm-init.sh" ]] && source "/Users/takahiro.nakayama/.gvm/bin/gvm-init.sh"
