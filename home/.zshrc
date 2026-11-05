# load completion system as early as possible
autoload -Uz compinit
compinit

eval "$($HOME/.local/bin/mise activate zsh)"

# deduplicate path entries
typeset -U path

# ignore duplicate history entries and share between prompts
setopt histignorealldups sharehistory
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

ZSH_CONFIG="$HOME/.config/zsh"
ZSHRC_D="$ZSH_CONFIG/zshrc.d"

while read -r file; do
    source "$ZSHRC_D/$file"
done <<<"$(find "$ZSHRC_D" -type f -exec basename {} \; | sort -n)"
