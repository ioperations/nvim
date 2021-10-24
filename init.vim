"      ____      _ __        _
"     /  _/___  (_) /__   __(_)___ ___
"    / // __ \/ / __/ | / / / __ `__ \
"  _/ // / / / / /__| |/ / / / / / / /
" /___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

if 1
    " vim-plug
    source $HOME/.config/nvim/general/plugins.vim
    
    " general settings
    source $HOME/.config/nvim/general/mappings.vim
    source $HOME/.config/nvim/general/settings.vim
    source $HOME/.config/nvim/general/langtemplate.vim
    source $HOME/.config/nvim/general/functions.vim
    source $HOME/.config/nvim/general/which-key.vim

    " dress 
    source $HOME/.config/nvim/plug-config/vim-airline.vim
    source $HOME/.config/nvim/plug-config/barbar.vim
    source $HOME/.config/nvim/plug-config/highlightyank.vim
    if(has('nvim'))
        luafile $HOME/.config/nvim/plug-config/tree-sitter.lua
    endif

    " completion
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/ultisnips.vim
    source $HOME/.config/nvim/plug-config/vim-auto-popmenu.vim

    " task system
    source $HOME/.config/nvim/plug-config/asynctask.vim
    source $HOME/.config/nvim/plug-config/vimspector.vim " 
    if(has('nvim'))
        luafile $HOME/.config/nvim/plug-config/nvim-dap.lua
        luafile $HOME/.config/nvim/plug-config/nvim-dapui.lua
    endif
    source $HOME/.config/nvim/plug-config/vimspector.vim
    source $HOME/.config/nvim/plug-config/vim-rust.vim
    source $HOME/.config/nvim/plug-config/vim-cmake.vim

    "editor plugin
    source $HOME/.config/nvim/plug-config/startfy.vim
    source $HOME/.config/nvim/plug-config/quickscope.vim
    source $HOME/.config/nvim/plug-config/vim-rooter.vim
    source $HOME/.config/nvim/plug-config/floaterm.vim
    source $HOME/.config/nvim/plug-config/closetags.vim
    source $HOME/.config/nvim/plug-config/tagalong.vim
    source $HOME/.config/nvim/plug-config/window-swap.vim
    source $HOME/.config/nvim/plug-config/vim-commentary.vim
    source $HOME/.config/nvim/plug-config/rnvimr.vim
    source $HOME/.config/nvim/plug-config/sneak.vim
    source $HOME/.config/nvim/plug-config/goyo.vim
    source $HOME/.config/nvim/plug-config/vim-prettier.vim
    source $HOME/.config/nvim/plug-config/autoformat.vim
    source $HOME/.config/nvim/plug-config/wildfire.vim
    source $HOME/.config/nvim/plug-config/auto-pairs.vim

    " better navigation
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/leaderF.vim
    source $HOME/.config/nvim/plug-config/easymotion.vim
    source $HOME/.config/nvim/plug-config/vim-easymotion.vim
    if(has('nvim'))
        source $HOME/.config/nvim/plug-config/hop.vim
    endif

    "git 
    source $HOME/.config/nvim/plug-config/gitblame.vim
    source $HOME/.config/nvim/plug-config/gitgutter.vim
    source $HOME/.config/nvim/plug-config/git-messenger.vim

    "markdown
    source $HOME/.config/nvim/plug-config/markdown-preview.vim

    "c++ doc and translate
    source $HOME/.config/nvim/plug-config/cppman.vim
    source $HOME/.config/nvim/plug-config/vim-translator.vim

    " some global variable overrite here
    source $HOME/.config/nvim/plug-config/last.vim
endif
inoremap <expr> <c-j> ("\<C-n>")

