alias gitst='git status'
alias clc='clear'
alias ls='ls -sFC'
alias ll='ls -a'
alias l='ls -sFC'
alias xloadimage='xloadimage -quiet -gamma 2.2'
alias vi='vim'
alias grep="grep --color=auto"
alias -s py=vi
alias -s c=vi
alias -s txt=vi
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# Houzz-specific alias
alias lr='ls -ltr'
alias tunnelConnect='/houzz/startTunnel.sh'
alias tunnelCheck='ps aux | grep ssh'
alias dataConnect='ssh data-util.hzd'

alias tmux='TERM=screen-256color-bce tmux'

# To reload the .zshrc command
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

if [[ $IS_MAC -eq 1 ]]; then
    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
    alias oo='open .' # open current directory in OS X Finder
    alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
fi