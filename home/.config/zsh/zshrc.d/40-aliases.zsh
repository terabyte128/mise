# git
alias gst="git status"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gdiff="git diff"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git pull"
alias glog="git log"
alias gre="git rebase"
alias gri="git rebase -i"
alias gsno="git show --name-only"
alias stash="git stash push"
alias unstash="git stash pop"

grih() {
    git rebase -i HEAD~$1
}

squash() {
    if [[ -z $1 ]]; then
        branch="main"
    else
        branch=HEAD~$1
    fi
    git rebase -i --autosquash $branch
}

groot() {
    root="$(git rev-parse --show-toplevel)"

    if [[ "$?" != "0" ]]; then
        return 1
    fi

    cd "$root"
}

# k8s
alias k="kubectl"
alias kg="kubectl get"
alias kgp="kubectl get pods"
alias klf="kubectl logs -f"

alias kks="kubectl -n kube-system"
alias kis="kubectl -n istio-system"
alias kos="kubectl -n opa-system"
alias kci="kubectl -n cluster-ingress"
alias kcm="kubectl -n cert-manager"
alias koi="kubectl -n opa-istio"
alias kd='kubectl -n default'

# follow logs for k8s pods with a specific app label
klfa() {
   kubectl logs -f -l app="$1"
}

_klfa() {
    for i in $(kubectl get deployments --no-headers | awk '{ print $1}'); do
        compadd $i
    done
}

kc() {
    if [[ ! -z $1 ]]; then
        kubectl config set-context --current --namespace=$1
    else
        kubectl config set-context --current --namespace=samwolfson
    fi
    direnv reload
}

compdef _klfa klfa

# manually set appearance, for ssh
alias darkmode='echo dark > ~/.config/appearance'
alias lightmode='echo light > ~/.config/appearance'


# misc
oz() {
    groot 2>/dev/null || cd $OZDIR
}

alias v="vim"
alias vi="vim"
alias vim="nvim"
alias watch="watch "
alias w="watch "
alias less="less -R"
alias l="ls"
alias ll="ls -la"
alias compose="docker compose"

function vactivate() {
    current="$PWD"

    while [[ "$current" != "/" ]]; do
        if [[ -d "$current/.venv" ]]; then
            echo "activating venv in $current"
            source "$current/.venv/bin/activate"
            break
        fi
        current=$(dirname "$current")
    done
}

if iswork; then
    alias dev="cd $OZDIR/infrastructure/orchestration/development"
fi
