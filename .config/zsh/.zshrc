# [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
## Options section
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt share_history
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
ZHISTDIR=$HOME/.local/share/zsh
HISTFILE=$ZHISTDIR/.zhistory
HISTSIZE=10000
SAVEHIST=5000
HISTCONTROL=ignoreboth
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section
source "$HOME/.config/aliasrc"

autoload -U compinit colors zcalc
compinit -d
colors

# enable substitution for prompt
setopt prompt_subst

echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)

source $ZDOTDIR/env_vars.zsh
source $ZDOTDIR/functions.zsh

# completions
source $ZDOTDIR/completions/pyenv.zsh
source $ZDOTDIR/completions/pip.zsh
source $ZDOTDIR/completions/fzf.zsh

# practical shortcuts
source ~/.config/shortcutrc

# Restore background program with ctrl+z
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Apply different settings for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
      alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
      ;;
  'tmux: server')
      source $ZDOTDIR/.tmux.zsh
      ;;
  *)
      # If tmux is not running, start it
      tmux new-session -A -s main
    ;;
esac

if command -v pyenv 1>/dev/null 2>&1
then
    eval "$(pyenv init -)"
fi
