# use bash-style word deletion (split on /)
autoload -U select-word-style
select-word-style bash

# key bindings
bindkey '^[^?' backward-kill-word
bindkey '^[b' backward-word
bindkey '^[f' forward-word

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# ctrl+P to previous, ctrl+N to next
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
