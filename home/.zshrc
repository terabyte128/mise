# load modern completion
autoload -U -z compinit
compinit

# load bash-style completion
autoload -U +X bashcompinit
bashcompinit

# active mise shims
eval "$($HOME/.local/bin/mise activate zsh)"

# deduplicate path entries
typeset -U path

# ignore duplicate history entries and share between prompts
setopt histignorealldups sharehistory
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# hint to programs like opencode that the terminal supports truecolor
export COLORTERM=truecolor

# 1Password SSH agent
sockfile="$HOME/.1password/agent.sock"
[[ -S "$sockfile" ]] && export SSH_AUTH_SOCK="$sockfile"

ZSH_CONFIG="$HOME/.config/zsh"
ZSHRC_D="$ZSH_CONFIG/zshrc.d"

while read -r file; do
    source "$ZSHRC_D/$file"
done <<<"$(find "$ZSHRC_D" -type f -exec basename {} \; | sort -n)"
