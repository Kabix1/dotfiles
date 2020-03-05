 # Fancy ctrl-z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

fs() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" | \
                  fzf --query="$1" --select-1 --exit-0) &&
        tmux switch-client -t "$session"
}

tm() {
    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
        tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
    fi
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

tmuxkillf () {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}

pkg() {
    operation="$1"
    case "$operation" in
        -a)
            yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S
            ;;
        -r)
            yay -Qeq | fzf -m --preview 'yay -Qi {1}' | xargs -ro yay -Rs
            ;;
        *)
            yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S
            ;;
    esac
}
