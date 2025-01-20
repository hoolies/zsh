# Coulors
autoload -U colors && colors

force_color_prompt=yes

# Exports
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--layout=reverse --inline-info'

export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_ALT_C_OPTS="
  --preview 'tree -C {}'"

export TERM=xterm-256color

export PS1="
%F{red}[%f%F{cyan}%~%f%F{red}]%f
 %F{white}%?  "

export RPROMPT=
set-title() {
    echo -e "\e]0;$*\007"
}

# Functions
# SSH
ssh() {
    set-title $*;
    /usr/bin/ssh -2 $*;
    set-title $HOST;
}

# Fuzzy
_fzf_compgen_path() {
    rg --files --glob "!.git" . "$1"
}

_fzf_compgen_dir() {
   fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    tree)         find . -type d | fzf --preview 'tree -C {}' "$@";;
    *)            fzf "$@" ;;
  esac
}


# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# Create Aliases for common tasks
alias ...='cd ../../..'
alias ..='cd ../..'
alias c="clear"
alias cdw='cd ~/workplace/'
alias grep='grep --color'
alias l.='ls -d .* --color --group-directories-first'
alias ll='ls --color -lAthr --group-directories-first'
alias ls='ls --color -A --group-directories-first'
alias mac='tail -n +44 /usr/share/wireshark/manuf | fzf'

# Emacs support
bindkey -e

# Sourcing automation
source /home/xrouvell/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/xrouvell/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Accepts suggestions with ctrl space
bindkey '^ ' autosuggest-accept

# History Settings
HISTFILE=~/.histfile
HISTSIZE=10000
HISTFILESIZE=10000
SAVEHIST=$HISTSIZE


setopt BEEP EXTENDED_GLOB NOMATCH
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
unsetopt AUTO_CD


# Tmux setting for remote servers
# if [ -z "$TMUX" ]; then
#     tmux attach -t devbox || tmux new -s devbox
# fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zshj 
