####.zshrc####
export EDITER=vim
bindkey -v
export CLICOLOR=true

#ignore capital small case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# history
setopt hist_ignore_dups
#visible history of matched command
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#colors
autoload colors
colors

setopt auto_cd
setopt correct

autoload -Uz compinit
compinit

#prompt
PROMPT="%{$fg[green]%}[%n@%m]%# %{$reset_color%}"
RPROMPT='[%d]'

# ls
alias ls="ls --color=auto -F"

# deno
export DENO_INSTALL="/home/ktg/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# roswell
export PATH="$HOME/.roswell/bin:$PATH"

# env
case ${OSTYPE} in
	linux*)
		;;
	darwin*)
		;;
esac

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
