"      ____      _ __        _
"     /  _/___  (_) /__   __(_)___ ___
"    / // __ \/ / __/ | / / / __ `__ \
"  _/ // / / / / /__| |/ / / / / / / /
" /___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

if 1
    source $HOME/.config/nvim/vim-plug/plugins.vim

    source $HOME/.config/nvim/general/mappings.vim
    source $HOME/.config/nvim/general/settings.vim
    source $HOME/.config/nvim/general/functions.vim
    source $HOME/.config/nvim/plug-config/quickscope.vim
    "
    source $HOME/.config/nvim/plug-config/easymotion.vim
    source $HOME/.config/nvim/plug-config/highlightyank.vim
    " Themes
    source $HOME/.config/nvim/plug-config/vim-airline.vim
    source $HOME/.config/nvim/plug-config/barbar.vim
    "" Plugin Configuration
    source $HOME/.config/nvim/general/which-key.vim
    source $HOME/.config/nvim/plug-config/vim-commentary.vim
    source $HOME/.config/nvim/plug-config/rnvimr.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/leaderF.vim
    source $HOME/.config/nvim/plug-config/sneak.vim
    source $HOME/.config/nvim/plug-config/vim-wiki.vim
    source $HOME/.config/nvim/plug-config/goyo.vim
    source $HOME/.config/nvim/plug-config/vim-rooter.vim
    source $HOME/.config/nvim/plug-config/gitgutter.vim
    source $HOME/.config/nvim/plug-config/git-messenger.vim
    source $HOME/.config/nvim/plug-config/closetags.vim
    source $HOME/.config/nvim/plug-config/floaterm.vim
    source $HOME/.config/nvim/plug-config/tagalong.vim
    source $HOME/.config/nvim/plug-config/asynctask.vim
    source $HOME/.config/nvim/plug-config/window-swap.vim
    source $HOME/.config/nvim/plug-config/markdown-preview.vim
    source $HOME/.config/nvim/plug-config/startfy.vim
    source $HOME/.config/nvim/plug-config/nerdtree.vim
    source $HOME/.config/nvim/plug-config/autoformat.vim
    source $HOME/.config/nvim/plug-config/ultisnips.vim
    source $HOME/.config/nvim/plug-config/vimspector.vim
    source $HOME/.config/nvim/plug-config/wildfire.vim
    source $HOME/.config/nvim/plug-config/vim-easymotion.vim
    source $HOME/.config/nvim/plug-config/gitblame.vim
    " source $HOME/.config/nvim/plug-config/nvimtree.vim
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/cppman.vim
    source $HOME/.config/nvim/plug-config/vim-auto-popmenu.vim
    source $HOME/.config/nvim/plug-config/vim-translator.vim
    source $HOME/.config/nvim/plug-config/vim-prettier.vim
    source $HOME/.config/nvim/plug-config/vimspector.vim " Uncomment if you want to use Vimspector
    if(has('nvim'))
        luafile $HOME/.config/nvim/plug-config/tree-sitter.lua
        source $HOME/.config/nvim/plug-config/hop.vim
    endif
    source $HOME/.config/nvim/plug-config/last.vim
endif


