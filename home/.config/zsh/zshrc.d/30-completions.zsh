# commands that use modern completion
command_exists eksctl && source <(eksctl completion zsh)
command_exists mise && source <(mise completion zsh)
command_exists fzf && source <(fzf --zsh) # NB: also sets up Ctrl-R search
command_exists rg && source <(rg --generate complete-zsh)

# commands that use bash-style completion
command_exists aws && command_exists aws_completer && complete -C "$(which aws_completer)" aws
command_exists terraform && complete -o nospace -C $(which terraform) terraform

# Describe otherwise-undescribed options taking one argument; %d is its description.
zstyle ':completion:*' auto-description 'specify: %d'

# Try expansion, normal completion, spelling correction, then correction plus completion.
zstyle ':completion:*' completer _expand _complete _correct _approximate

# Group matches by their completion tags, such as files, directories, and options.
zstyle ':completion:*' group-name ''

# Generate LS_COLORS variable if it exists, and use it for completion colors,
# splitting its colon-separated specifications.

if command_exists dircolors; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# Request default colors; the more specific default-tag rule above takes precedence.
zstyle ':completion:*' list-colors ''

# Page long lists with a highlighted prompt; %p shows Top, Bottom, or a percentage.
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

# Try normal matching, lowercase matching uppercase, then fully case-insensitive matching.
# Finally allow abbreviated ._- components and substrings; this last pass is case-sensitive.
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# Enter interactive menu selection when the matches do not fit on the screen.
zstyle ':completion:*' menu select=long

# Show a highlighted scrolling prompt with the selected match's position in long menus.
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Highlight the leading PID in bold red in kill's process completion list.
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Complete kill arguments using your processes, showing PID, CPU, terminal, time, and command.
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
