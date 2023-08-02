/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install ansible
brew install git
mkdir ~/.dotfiles && cd ~/.dotfiles && git clone https://github.com/jestx87/zsh_dotfiles.git . && cd ~
ansible-playbook ~/.dotfiles/install/macos/main.yml