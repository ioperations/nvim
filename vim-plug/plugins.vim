" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Better Comments
Plug 'tpope/vim-commentary'
" Change dates fast
Plug 'tpope/vim-speeddating'
" Convert binary, hex, etc..
Plug 'glts/vim-radical'
" Repeat stuff
Plug 'tpope/vim-repeat'
" Text Navigation
Plug 'unblevable/quick-scope'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'phaazon/hop.nvim', { 'branch': 'pre-extmarks' }
Plug 'easymotion/vim-easymotion'
" Useful for React Commenting
Plug 'suy/vim-context-commentstring'
" highlight all matches under cursor
" Plug 'RRethy/vim-illuminate'

if exists('g:vscode')
    " Easy motion for VSCode
    Plug 'asvetliakov/vim-easymotion'
    Plug 'machakann/vim-highlightedyank'
else
    Plug 'vim-airline/vim-airline'
    Plug 'junegunn/rainbow_parentheses.vim'
    " Sneak
    " Plug 'justinmk/vim-sneak'
    " Surround
    Plug 'tpope/vim-surround'
    " Files
    Plug 'tpope/vim-eunuch'
    " Have the file system follow you around
    Plug 'airblade/vim-rooter'
    " auto set indent settings
    Plug 'tpope/vim-sleuth'
    " Better Syntax Support
    " Plug 'nvim-treesitter/nvim-treesitter'
    "Plug 'sheerun/vim-polyglot'
    " Cool Icons
    Plug 'ryanoasis/vim-devicons'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    Plug 'gcmt/wildfire.vim'
    " Closetags
    "Plug 'alvan/vim-closetag'
    " Themes
    "Plug 'christianchiarulli/nvcode.vim'
    " Plug 'ChristianChiarulli/nv-code'
    " Plug 'kyazdani42/blue-moon'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'skywind3000/vim-auto-popmenu'
    Plug 'skywind3000/vim-dict'

    Plug 'neoclide/coc-snippets',
    " Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'derekwyatt/vim-fswitch'
    " Plug 'ycm-core/YouCompleteMe',
    Plug 'metakirby5/codi.vim'
    " Plug 'nathanaelkane/vim-indent-guides'
    Plug 'Yggdroot/indentLine'
    " Plug 'lukas-reineke/indent-blankline.nvim'
    " Plug 'Yggdroot/indentLine'
    "cpp
    " Plug 'octol/vim-cpp-enhanced-highlight'
    " Plug 'bfrg/vim-cpp-modern'
    "go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " Status Line
    "Plug 'theniceboy/eleline.vim'
    "Plug 'kevinhwang91/rnvimr'
    "Plug 'ajmwagar/vim-deus'
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
    if has('nvim')
	Plug 'sharkdp/fd'
	Plug 'sharkdp/bat'
	Plug 'BurntSushi/ripgrep'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	" telescope dependency
	Plug 'folke/trouble.nvim'
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	" Git
	Plug 'f-person/git-blame.nvim'
    endif
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'
    " Terminal
    Plug 'voldikss/vim-floaterm'
    " Start Screen
    Plug 'mhinz/vim-startify'
    " Vista
    Plug 'liuchengxu/vista.vim'
    " Plug 'preservim/tagbar'
    " See what keys do like in emacs
    Plug 'liuchengxu/vim-which-key'
    " Zen mode
    Plug 'junegunn/goyo.vim'
    " Snippets
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'mattn/emmet-vim'
    " Interactive code
    Plug 'metakirby5/codi.vim'
    " Debugging
    Plug 'puremourning/vimspector'
    " Plug 'cpiger/NeoDebug'
    " Better tabline
    "Plug 'mg979/vim-xtabline'
    " undo time travel
    Plug 'mbbill/undotree'
    " Find and replace
    Plug 'ChristianChiarulli/far.vim'
    " Plug 'brooth/far.vim'
    " Auto change html tags
    Plug 'AndrewRadev/tagalong.vim'
    " live server
    Plug 'turbio/bracey.vim'
    " Smooth scroll
    Plug 'psliwka/vim-smoothie'
    " async tasks
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'
    " Swap windows
    Plug 'wesQ3/vim-windowswap'
    " Markdown Preview
    " Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'jceb/vim-orgmode'
    " Easily Create Gists
    Plug 'mattn/vim-gist'
    "Plug 'mattn/webapi-vim'
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'sumneko/lua-language-server' ,{'dir':'~/.config/nvim/autoload/plugged/lua-language-server/','do':'git submodule update --init --recursive && cd 3rd/luamake && ninja -f compile/ninja/linux.ninja && cd ../..  && ./3rd/luamake/luamake rebuild'}
    " Rainbow brackets
    " Plug 'luochen1990/rainbow'
    " Async Linting Engine
    " TODO make sure to add ale config before plugin
    " Plug 'dense-analysis/ale'
    " Better Whitespace
    Plug 'ntpeters/vim-better-whitespace'
    " Multiple Cursors
    " TODO add this back in change from C-n
    " Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'moll/vim-bbye'
    " Plug 'yuezk/vim-js'
    " TypeScript
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'maxmellon/vim-jsx-pretty'

    Plug 'prettier/vim-prettier', {
		\ 'do': 'npm install',
		\ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact'] }
    " Plug 'jelera/vim-javascript-syntax'
    " Plugin Graveyard

    "input method
    " Plug 'h-youhei/vim-fcitx'
    "swift
    Plug 'lilyball/vim-swift'
    Plug 'xolox/vim-misc'
    " Plug 'xolox/vim-session'
    Plug 'morhetz/gruvbox'

    "sql
    Plug 'tpope/vim-dadbod'
    Plug 'kristijanhusak/vim-dadbod-ui'
    Plug 'kristijanhusak/vim-dadbod-completion'
    "multi cursor
    Plug 'mg979/vim-visual-multi'
    " jsx syntax support
    " Typescript syntax
    " Plug 'HerringtonDarkholme/yats.vim'
    " Multiple Cursors
    " Plug 'terryma/vim-multiple-cursors'
    " Plug 'kaicataldo/material.vim'
    " Plug 'NLKNguyen/papercolor-theme'
    " Plug 'tomasiser/vim-code-dark'
    " Vim Wiki
    " Plug 'https://github.com/vimwiki/vimwiki.git'
    " Better Comments
    " Plug 'jbgutierrez/vim-better-comments'
    " Echo doc
    " Plug 'Shougo/echodoc.vim'
    " Plug 'hardcoreplayers/spaceline.vim'
    " Plug 'vim-airline/vim-airline-themes'
    " Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    " Plug 'arcticicestudio/nord-vim'
    " Ranger
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim' " ranger dependency
    " Making stuff
    " Plug 'neomake/neomake'
    " Plug 'mhinz/vim-signify'
    " Plug 'easymotion/vim-easymotion'
    " Plug 'preservim/nerdcommenter'
    "latex
    " A Vim Plugin for Lively Previewing LaTeX PDF Output
    Plug 'conornewton/vim-latex-preview'
    " Plug 'xuhdev/vim-latex-live-preview'
    " Plug 'brooth/far.vim'
    " Plug 'atishay/far.vim'
    "
    Plug 'Chiel92/vim-autoformat' "\f to autoformat the file
    "Plug 'skywind3000/vim-cppman'
    Plug 'ioperations/vim-cppman'
    " Plug 'skywind3000/vim-cppman'
    Plug 'rhysd/vim-clang-format'
    " File navigation
    Plug 'scrooloose/nerdtree'
    " requires
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " translator
    Plug 'voldikss/vim-translator'
    Plug 'thaerkh/vim-workspace'
endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
	    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	    \|   PlugInstall --sync | q
	    \| endif


source ~/.config/nvim/langtemplate.vim
