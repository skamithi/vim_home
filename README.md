my vim home directory

Done using [Sync plugins with git modules and
pathogens](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)

## Requirements

* vim-nox

## Usage

```
sudo apt-get install vim-nox
mv ~/.vim ~/vim.old
git clone http://github.com/skamithi/vim_home ~/.vim --recursive
cd ~/.vim
cp vimrc ~/.vimrc
```
