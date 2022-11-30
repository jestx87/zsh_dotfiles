export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$HOME/.local/bin:$PATH"

plugins=(
terraform
kubectl
docker
git
zsh-autosuggestions
sudo
zsh-syntax-highlighting
dirhistory
)

source $ZSH/oh-my-zsh.sh
source ~/.dotfiles/.zsh_autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
if command -v fdfind &> /dev/null
then
  alias fd='/usr/bin/fdfind'
  export FZF_DEFAULT_COMMAND='fdfind --type f --color=never --hidden'
  export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
  export FZF_ALT_C_COMMAND='fdfind --type d . --color=never --hidden'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
elif  ! command -v fdfind && ! command -v fd &> /dev/null
then
  export FZF_DEFAULT_COMMAND='find . -type f'
  export FZF_ALT_C_COMMAND='find . -type d'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# custom stuff
source ~/.dotfiles/.zsh_functions

# alias def
alias sc!='fc -e "sed -i -e \"s/ssh/ssh-copy-id -f -i ~\/.ssh\/id_rsa/\""'
alias se='sudoedit'
alias apv='ansible_playbook_vagrant'
alias apa='ansible_playbook_ansible'
alias afv='ansible_facts_vagrant'
alias afa='ansible_facts_ansible'
alias buu='brew update && brew upgrade && brew autoremove'
alias vcs='ssh-add -L | grep -F "parallels" | ssh-add -d -'
alias dgp='dotfiles_git_pull'
alias omzu='omzupdate'
alias apvsphere='ansible_playbook_vsphere'
alias starshipu='starshipupdate'
alias sui='sudo -i'
alias vu='vagrant up'
alias vd='vagrant destroy'
alias vs='vagrant ssh'
alias sp='export https_proxy=$proxy'
alias ap='ansible-playbook -e 'local_ansible_python_interpreter=/usr/bin/python3' --vault-password-file=.vaultpass $@'
