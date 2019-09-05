# Checking OS type, assuming MacOS or Linux
OS_TYPE=-1
if [[ "$OSTYPE" == "darwin"* ]]; then # MAC OS
  OS_TYPE=0
else
  OS_TYPE=1
fi

# Configure system wide dependencies
if [ $OS_TYPE == 0 ]; then
  echo 'Installing dependencies for MacOS'

  # Brew
  if ! [ -x "$(command -v brew)" ]; then
    echo 'Installing brew' >&2
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # Brew cask
  if [ -x "$(command -v brew)" ]; then
    brew tap caskroom/cask
    brew cask install \
      alfred \
      caffeine \
      docker \
      google-chrome \
      flux \
      spectacle \
      sublime-text \
      iterm2
  fi

  # Brew install
  if [ -x "$(command -v brew)" ]; then
    brew install \
      zsh \
      zsh-completions \
      tree \
      fzf \
      ack \
      git \
      fswatch \
      autojump \
      jq \
      tmux \
      vim
  fi

  # Link for sublime text
  SUBL_LINK=/usr/local/bin/subl
  if ! test -f $SUBL_LINK; then
    ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
  fi
fi

# Link dot files
DOT_FILE_PATH="$(pwd)"

# VIM
VIMRC="$HOME/.vimrc"
if test -f $VIMRC; then
  echo "vimrc file exists, skipping, to force retry, delete local vim files" # TODO: back up and delete on command
else
  ln -s "${DOT_FILE_PATH}/vim/vimrc" $VIMRC
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
fi

# SHELL
VIMRC="$HOME/.vimrc"
if [ $OS_TYPE==0 ]; then # MAC OS
  ZSHRC="$HOME/.zshrc"
  if test -f $ZSHRC; then
    echo "zshrc file exists, skipping, to force retry, delete local zsh files" # TODO: back up and delete on command
  else
    curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    git clone https://github.com/peterhurford/git-it-on.zsh ~/.oh-my-zsh/custom/plugins/git-it-on
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    rm $ZSHRC # Remove the zshrc from oh-my-zsh
    ln -s "${DOT_FILE_PATH}/zsh/zshrc" $ZSHRC
    touch "$HOME/.zsh_local"
    chsh -s $(which zsh)
  fi
else
  BASHRC="$HOME/.bash_profile"
  if test -f $BASHRC; then
    echo "bashrc file exists, skipping, to force retry, delete local bash files" # TODO: back up and delete on command
  else
    ln -s "${DOT_FILE_PATH}/bash/bash_profile" "$HOME/.bash_profile"
    touch "$HOME/.bash_local"
  fi
fi

# TMUX
TMUX_CONF="$HOME/.tmux.conf"
if test -f $TMUX_CONF; then
  echo "tmux.conf file exists, skipping, to force retry, delete local tmux files" # TODO: back up and delete on command
else
  ln -s "${DOT_FILE_PATH}/tmux/tmux.conf" $TMUX_CONF
fi

