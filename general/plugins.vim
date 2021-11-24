" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
if 1
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'm-pilia/vim-ccls'
    Plug 'rhysd/vim-clang-format'
    Plug 'neoclide/coc-snippets'
    Plug 'honza/vim-snippets'
    Plug 'skywind3000/vim-auto-popmenu'
    Plug 'skywind3000/vim-dict'

    " c++ doc and translate
    "Plug 'skywind3000/vim-cppman'
    Plug 'ioperations/vim-cppman'
    "Plug 'voldikss/vim-translator'

    " search
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'
    Plug 'easymotion/vim-easymotion'
    if has("nvim")
        Plug 'phaazon/hop.nvim'
        Plug 'norcalli/nvim-colorizer.lua'
    endif

    " fuzzy 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'Yggdroot/LeaderF', { 'do' : ':LeaderfInstallCExtension' }

    Plug 'tpope/vim-commentary' " Better Comments
    Plug 'tpope/vim-speeddating' " Change dates fast
    Plug 'tpope/vim-repeat' " Repeat stuff
    " Useful for React Commenting
    Plug 'suy/vim-context-commentstring'

    Plug 'machakann/vim-highlightedyank'

    " dress
    Plug 'vim-airline/vim-airline'
    if(has('nvim'))
        Plug 'romgrk/barbar.nvim'
    endif
    Plug 'kyazdani42/nvim-web-devicons' " barbar's dependency
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/seoul256.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'psliwka/vim-smoothie' " Smooth scroll

    " tasks system
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'neomake/neomake'
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'puremourning/vimspector' " Debugging
    Plug 'rust-lang/rust.vim'   "cargo vim
    Plug 'mattn/webapi-vim' " cargo dependency
    Plug 'cdelledonne/vim-cmake' " cmake intergration

    "editor plugin
    Plug 'mg979/vim-visual-multi' "multi cursor
    Plug 'tpope/vim-surround' " Surround
    Plug 'airblade/vim-rooter' " Have the file system follow you around
    Plug 'jiangmiao/auto-pairs' " Auto pairs for '(' '[' '{'
    Plug 'gcmt/wildfire.vim' " Closetags
    Plug 'mhinz/vim-startify' " Start Screen
    Plug 'mbbill/undotree' " undo time travel
    Plug 'wesQ3/vim-windowswap' " Swap windows
    Plug 'Chiel92/vim-autoformat'
    Plug 'francoiscabrol/ranger.vim' " file browser
    Plug 'voldikss/vim-floaterm' " Terminal
    Plug 'liuchengxu/vim-which-key' " See what keys do like in emacs
    Plug 'junegunn/goyo.vim' " Zen mode
    if has ('nvim')
        Plug 'nvim-treesitter/nvim-treesitter', { 'do' : ':TSUpdate' } " syntax highlight per filetype
    endif

    "git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'

    "html
    Plug 'mattn/emmet-vim' " html tag expand
    Plug 'AndrewRadev/tagalong.vim' " Auto change html tags

    "go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Markdown Preview
    Plug 'iamcco/markdown-preview.nvim', { 
                \ 'do': { -> mkdp#util#install() }, 
                \ 'for': ['markdown', 'vim-plug']}

    "org mode
    Plug 'jceb/vim-orgmode'

    "lua
    Plug 'sumneko/lua-language-server' ,{ 
                \ 'dir' : '~/.config/nvim/autoload/plugged/lua-language-server/', 
                \ 'do' : 'git submodule update --init --recursive && cd 3rd/luamake && 
                \ ninja -f compile/ninja/linux.ninja && cd ../..  && 
                \ ./3rd/luamake/luamake rebuild' }

    "db
    Plug 'tpope/vim-dotenv'
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'

    " TypeScript
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'prettier/vim-prettier', {
                \ 'do' : 'npm install',
                \ 'for' : [ 'javascript', 'typescript', 
                \ 'typescriptreact', 'javascriptreact' ] }

    "swift
    Plug 'lilyball/vim-swift'
endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
