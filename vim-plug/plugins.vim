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
Plug 'easymotion/vim-easymotion'
" Useful for React Commenting
Plug 'suy/vim-context-commentstring'
" highlight all matches under cursor
" Plug 'RRethy/vim-illuminate'

if 1
    " Easy motion for VSCode
    Plug 'asvetliakov/vim-easymotion'
    Plug 'machakann/vim-highlightedyank'
    Plug 'vim-airline/vim-airline'
    Plug 'romgrk/barbar.nvim'
    " barbar's dependency
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'junegunn/rainbow_parentheses.vim'
    " Sneak
    " Plug 'justinmk/vim-sneak'
    " Surround
    Plug 'tpope/vim-surround'
    " Have the file system follow you around
    Plug 'airblade/vim-rooter'
    " auto set indent settings
    "Plug 'tpope/vim-sleuth'
    " Plug 'nvim-treesitter/nvim-treesitter'
    " Cool Icons
    "Plug 'ryanoasis/vim-devicons'
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
    Plug 'neoclide/coc-snippets',
    Plug 'skywind3000/vim-auto-popmenu'
    Plug 'skywind3000/vim-dict'

    Plug 'neomake/neomake'
    Plug 'Yggdroot/indentLine'
    "go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " Status Line
    "Plug 'theniceboy/eleline.vim'
    "Plug 'kevinhwang91/rnvimr'
    "Plug 'ajmwagar/vim-deus'
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'Yggdroot/LeaderF', { 'do' : ':LeaderfInstallCExtension' }
    if has ('nvim')
        Plug 'sharkdp/fd'
        Plug 'sharkdp/bat'
        Plug 'BurntSushi/ripgrep'
        Plug 'nvim-treesitter/nvim-treesitter', { 'do' : ':TSUpdate' }
        " telescope dependency
        Plug 'norcalli/nvim-colorizer.lua'
        Plug 'phaazon/hop.nvim'
        " Git
    endif
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    Plug 'rhysd/git-messenger.vim'
    " Terminal
    Plug 'voldikss/vim-floaterm'
    " Start Screen
    Plug 'mhinz/vim-startify'
    " See what keys do like in emacs
    Plug 'liuchengxu/vim-which-key'
    " Zen mode
    Plug 'junegunn/goyo.vim'
    " Snippets
    Plug 'honza/vim-snippets'
    "Plug 'SirVer/ultisnips'
    Plug 'mattn/emmet-vim'
    " Interactive code
    "Plug 'metakirby5/codi.vim'
    " Debugging
    Plug 'puremourning/vimspector'
    " Plug 'cpiger/NeoDebug'
    " Better tabline
    " undo time travel
    Plug 'mbbill/undotree'
    " Find and replace
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
    "Plug 'mattn/webapi-vim'
    Plug 'sumneko/lua-language-server' ,{ 'dir' : '~/.config/nvim/autoload/plugged/lua-language-server/', 'do' : 'git submodule update --init --recursive && cd 3rd/luamake && ninja -f compile/ninja/linux.ninja && cd ../..  && ./3rd/luamake/luamake rebuild' }
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
    " Plug 'yuezk/vim-js'
    " TypeScript
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'maxmellon/vim-jsx-pretty'

    Plug 'prettier/vim-prettier', {
                \ 'do' : 'npm install',
                \ 'for' : [ 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' ] }
    " Plug 'jelera/vim-javascript-syntax'
    " Plugin Graveyard

    "swift
    Plug 'lilyball/vim-swift'
    " Plug 'xolox/vim-session'
    Plug 'morhetz/gruvbox'

    "multi cursor
    Plug 'mg979/vim-visual-multi'
    " jsx syntax support
    " Typescript syntax
    " Plug 'HerringtonDarkholme/yats.vim'
    " Ranger
    Plug 'francoiscabrol/ranger.vim'
    " Making stuff
    " Plug 'mhinz/vim-signify'
    " Plug 'preservim/nerdcommenter'
    "latex
    " A Vim Plugin for Lively Previewing LaTeX PDF Output
    "
    Plug 'Chiel92/vim-autoformat'
    "Plug 'skywind3000/vim-cppman'
    Plug 'ioperations/vim-cppman'

    " translator
    Plug 'voldikss/vim-translator'
endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif


source ~/.config/nvim/langtemplate.vim
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif
