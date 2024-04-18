export KUBECONFIG=~/.kube/config
alias python=python3
alias k=kubectl
alias kp="kubectl get pods"
alias kn="kubectl get nodes"
alias kl="kubectl logs"

alias g=git

function dcid() {
    docker ps -qf "ancestor=$1"
}

function dcl() {
    docker logs $(cid $1)
}
