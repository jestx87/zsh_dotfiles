export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

plugins=(
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

if command -v batcat &> /dev/null
then
    alias bat='/usr/bin/batcat'
fi

# custom stuff
# functions
function ansible_playbook_vagrant() {
  DIR=$PWD; cd ~/dev/pm-admin/; ansible-playbook --user=vagrant --vault-password-file=.vaultpass $@; cd $DIR
}
function ansible_facts_vagrant() {
  DIR=$PWD; cd ~/dev/pm-admin/; ansible --user=vagrant --vault-password-file=.vaultpass -m ansible.builtin.setup $@; cd $DIR
}
function git_dotfiles_pull() {
  git -C ~/.dotfiles pull
  git -C ~/.oh-my-zsh pull
  git -C ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull
  git -C ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull
}

# alias def
alias sc!='fc -e "sed -i -e \"s/ssh/ssh-copy-id -f -i ~\/.ssh\/id_rsa/\""'
alias se='sudoedit'
alias apv='ansible_playbook_vagrant'
alias afv='ansible_facts_vagrant'
alias buu='brew update && brew upgrade && brew autoremove'
alias vcs='ssh-add -L | grep -F "parallels" | ssh-add -d -'
alias dgp='git_dotfiles_pull'
