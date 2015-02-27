#!/bin/bash

for i in `ls $HOME/.vim/bundle`; do
  echo "Update Git for $i"
  if [ -d $i ]; then
    cd "$i"
    git pull
  fi
 cd $HOME/.vim/bundle
done


