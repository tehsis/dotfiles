$uname=`uname`

set -e

function install() {
  echo "Installing $1..."
  if [[ $uname -eq "Darwin" ]]
    brew install $1
  then
  fi
}

function cpIfNotExists() {
    if [[ ! -f $2  ]]
      echo "Copying $1 to $2"
      cp $1 $2
    then
      echo "$2 already exists!"
    fi
}

if [[ $uname -eq "Darwin" ]]
then
   echo "Installing Homebrew... (https://brew.sh/)"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ ! -f ~/.oh-my-zsh ]]
then
echo "Installing OhMyZsh... (https://github.com/robbyrussell/oh-my-zsh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "~/.oh-my-zsh found!"
fi

install "git"
install "tmux"

if [[ ! -f ~/.vimrc ]]
then
echo "Install Ultimate vimrc (https://github.com/amix/vimrc)"
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
else
    echo "~/.vimrc found!"
fi

echo "Copying configuration files.."

cpIfNotExists ./vimrc ~/.vimrc
cpIfNotExists ./zshrc ~/.zshrc
