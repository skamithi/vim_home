my vim home directory

Done using [Sync plugins with git modules and
pathogens](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)

## Usage

```
mv ~/.vim ~/vim.old
git clone http://github.com/skamithi/vim_home ~/.vim
cd ~/.vim
cp vimrc ~/.vimrc
git submodule init
git submodule update
```
