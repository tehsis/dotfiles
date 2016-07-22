#!/bin/zsh
# @tehsis
# Copies the dotfiles to its corresponding location.
# All removed files are saved as ./original_file_backup

set -e

function backupCopy {
 echo "* Copying "$1 "..."
 if [[ -a $2 ]] cp -r $2 $1"_backup" 
 echo "** Original files backed up to "$1"_backup ..."  
 echo "Removing $2 ..."
 rm -rf $2 
 echo "Creating symlink to $1 in $2"
 ln -s $1 $2 && echo "** Done!"
}

if [[ -x $(command -v zsh) ]]
then
  echo "Installing oh-my-zsh..."
  [[ -a ~/.oh-my-zsh ]] && echo "Good! you already have Oh-my-zsh" || curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
else
  echo "Error: Make sure you have zsh installed on your system."
fi

if [[ -x $(command -v vim) ]]
then
  backupCopy `pwd`/vim ~/.vim 
  backupCopy `pwd`/vimrc ~/.vimrc 
else
  echo "Error: vim not found."
fi

if [[ -x $(command -v terminator) ]] 
then
  backupCopy config/terminator ~/.config/terminator 
else 
 print "Error: terminator not found."
fi

echo "Completed!"
