#!/bin/bash

cur_dir=`pwd`
MYWORK=~/mywork

# apt-get install
$MYWORK/env/apt_list.sh

# cask
ln -snf $MYWORK/env/emacs/Cask ~/.emacs.d/Cask
cd ~/.emacs.d
cask install

# finish
cd "${cur_dir}"
