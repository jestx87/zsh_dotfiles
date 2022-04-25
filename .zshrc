export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

plugins=(
#kubectl
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
# functions
function ansible_playbook_vsphere() {
  read -s PASS"?vSphere Password (will be hidden):"; export VMWARE_PASSWORD=$PASS; DIR=$PWD; cd ~/dev/pm-admin/; ansible-playbook -e 'local_ansible_run_vsphere=true local_ansible_python_interpreter=/usr/bin/python3' --user=vagrant --vault-password-file=.vaultpass $@; cd $DIR; export VMWARE_PASSWORD=
}
function ansible_playbook_vagrant() {
  DIR=$PWD; cd ~/dev/pm-admin/; ansible-playbook -e 'local_ansible_python_interpreter=/usr/bin/python3' --user=vagrant --vault-password-file=.vaultpass $@; cd $DIR
}
function ansible_facts_vagrant() {
  if [ -f ~/.ssh/vagrant_key ]; then
    VAGRANTKEYFILE="--private-key=~/.ssh/vagrant_key"
  else
    VAGRANTKEYFILE=""
  fi
  DIR=$PWD; cd ~/dev/pm-admin/; ansible -e 'local_ansible_python_interpreter=/usr/bin/python3' --user=vagrant $VAGRANTKEYFILE --vault-password-file=.vaultpass -m ansible.builtin.setup $@; cd $DIR
}
function dotfiles_git_pull() {
  if [ ! -z  "$proxy" ]; then
    export http_proxy=$proxy
    export https_proxy=$proxy
  fi
  dotfiles_folder=( ~/.dotfiles ~/.oh-my-zsh ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting  )
  for i in "${dotfiles_folder[@]}"
  do
	  echo "$i"; git -C $i pull
  done
  if [ ! -z  "$proxy" ]; then
    unset http_proxy
    unset https_proxy
  fi
}

# alias def
alias sc!='fc -e "sed -i -e \"s/ssh/ssh-copy-id -f -i ~\/.ssh\/id_rsa/\""'
alias se='sudoedit'
alias apv='ansible_playbook_vagrant'
alias afv='ansible_facts_vagrant'
alias buu='brew update && brew upgrade && brew autoremove'
alias vcs='ssh-add -L | grep -F "parallels" | ssh-add -d -'
alias dgp='dotfiles_git_pull'
alias apvsphere='ansible_playbook_vsphere'
alias starshipupdate='sh -c "$(curl -fsSL https://starship.rs/install.sh)"'
alias sui='sudo -i'
