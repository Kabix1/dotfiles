# Color man pages

# export LESS_TERMCAP_mb=$'\E[01;32m'
# export LESS_TERMCAP_md=$'\E[01;32m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;47;34m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;36m'
# export LESS=-r

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PYTHONSTARTUP=~/.config/python/pythonrc

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export PAGER="less"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export DOCKER_HOST=unix:///run/user/1000/docker.sock
