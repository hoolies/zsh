# Colors
autoload -U colors && colors

# xozide
eval "$(zoxide init zsh)"

# Add highlight enabled tab completion with colors
zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

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
 %F{cyan}%~%f
 %F{white}%?  "

PS1=$'\n\n\n\n\n\e[6A'"$PS1"

export RPROMPT=
set-title() {
    echo -e "\e]0;$*\007"
}

export PATH=$PATH:/usr/local/go/bin

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


# _fzf_complete_sv(){
#   local cmd="$1" service
#   service="$2"
#   if [[ -n "$cmd" && "$cmd" =~ ^(check|down|exit|force-reload|force-restart|force-shutdown|force-stop|once|reload|restart|shutdown|status|stop|try-restart|up)$ ]]; then
#     _fzf_coplete -- "$@" < <(
#       find /etc/sv -maxdepth 1 -mindepth 1 -type d
#     )
#   fi
# }

_fzf_complete_git() {
  _fzf_complete -- "$@" < <(
    git --help -a | grep -E '^\s+' | awk '{print $1}'
  )
}

# Add an empty line after the output
precmd() { print "" }

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
alias grep='grep --color'
alias l.='ls -d .* --color --group-directories-first'
alias ll='ls --color -lAthr --group-directories-first'
alias ls='ls --color -A --group-directories-first'
alias mac='tail -n +44 /usr/share/wireshark/manuf | fzf'

# Emacs support
bindkey -e

# Accepts suggestions with ctrl space
bindkey '^ ' autosuggest-accept

# History Settings
HISTFILE=~/.histfile
HISTFILESIZE=10000
HISTSIZE=10000
SAVEHIST=$HISTSIZE


setopt APPEND_HISTORY
setopt BEEP EXTENDED_GLOB NOMATCH
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
unsetopt AUTO_CD


# Checks if syntax highlighting is install
if [ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
  echo "Installing zsh syntax highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh/zsh-syntax-highlighting
fi

# Check if zsh autosuggestions is installed
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
  echo "Installing zsh autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
fi

# check if zsh history susbtring search
if [ ! -d "$HOME/.zsh/zsh-history-substring-search" ]; then
  echo "Installing zsh history substring search."
  git clone https://github.com/zsh-users/zsh-history-substring-search.git $HOME/.zsh/zsh-history-substring-search
fi

# check if fzf dir navigator exists exists
if [ ! -d "$HOME/.zsh/fzf-dir-navigator" ]; then
  echo "Installing fzf dir navigator."
  git clone https://github.com/KulkarniKaustubh/fzf-dir-navigator.git $HOME/.zsh/fzf-dir-navigator
fi



# Tmux setting for remote servers
# if [ -z "$TMUX" ]; then
#     tmux attach -t devbox || tmux new -s devbox
# fi


# Sourcing
source $HOME/.local/bin/env
source $HOME/.zsh/fzf-dir-navigator/fzf-dir-navigator.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source <(fzf --zsh)
