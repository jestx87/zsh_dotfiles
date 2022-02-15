export ZSH="$HOME/.oh-my-zsh"
export EDITOR=vim

plugins=(
git
zsh-autosuggestions
sudo
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias sc!='fc -e "sed -i -e \"s/ssh/ssh-copy-id -f -i ~\/.ssh\/id_rsa/\""'
alias se='sudoedit'
alias vap='ansible-playbook --user=vagrant --vault-password-file=.vaultpass'
eval "$(starship init zsh)"

source ~/.dotfiles/.zsh_autocompletion
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :100 {}'"
export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v batcat &> /dev/null
then
    alias bat='/usr/bin/batcat'
fi

