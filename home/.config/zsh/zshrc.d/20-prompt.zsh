setopt PROMPT_SUBST # enable prompt substitution

source "$HOME/.config/zsh/plugins/shrink-path.plugin.zsh"

leftprompt() {
    local builder=""

    if [[ $IS_DEVCONTAINER = "true" ]]; then
        builder+="%F{blue}d%f "
    fi

    if [[ ! $USER =~ "sam" ]]; then
        builder+="$USER "
    fi

    local git_root
    git_root=$(git rev-parse --show-toplevel 2> /dev/null)
    local git_status=$?

    local mypath
    local orig_path=$(shrink_path -l -t "$PWD")

    builder+="$orig_path "

    local branch=$(git branch 2> /dev/null | grep '*' | cut -c 3-)
    local git_dirty=$(git status --short 2> /dev/null)

    if [[ ! -z $branch ]]; then
        if [[ "$branch" == *"rebasing"* ]]; then
            branch=$(echo $branch | cut -c 13- | rev | cut -c 2- | rev)
        elif [[ "$branch" == *"detached"* ]]; then
            branch="%F{red}detached%f@$(echo $branch | cut -c 19- | rev | cut -c 2- | rev)"
        fi
        builder+="%B($branch)%b "
    fi

    if [[ ! -z $git_dirty ]]; then
        builder+="%F{red}x%f "
    fi

    local context=""

    # attempt to figure out kube namespace if in an infrastructure/{env} directory
    if iswork && [ ! -z $ROOT_DIR ]; then

        local raw_context=$(kubectl config view --minify 2>&1 | grep namespace | cut -c 16-)

        # print kube context if not me or if in stage/prod
        if [[ $raw_context == "default" ]]; then
            local cluster=$(kubectl config view --minify 2>&1 | grep name | head -n 1)
            if [[ $cluster == *"stage"* ]]; then
                # we're in stage(!)
                context="%F{red}!%f "
            elif [[ $cluster =~ "production" ]]; then
                # we're in prod(!!)
                context="%F{red}!!%f "
            else
                context="%F{magenta}! default%f "
            fi
        elif [[ $raw_context == $USER ]]; then
            # my context, do nothing
            true
        elif [[ ! -z $raw_context ]]; then
            context="%F{magenta}! ${raw_context}%f "
        fi
    fi

    builder+="$context"

    # echo -n '\e[6 q' # cursor bar
    echo "${builder}$ "
}

PROMPT='$(leftprompt)'
