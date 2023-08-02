#### run -> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jestx87/install/macos/macos.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install ansible
brew install git
mkdir ~/.dotfiles && cd ~/.dotfiles && git clone https://github.com/jestx87/zsh_dotfiles.git