" Basic Key Mappings
" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv


" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" better navigation
inoremap <C-a> <c-o>0
inoremap <C-e> <c-o>$

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Easy CAPS
" inoremap <c-u> <ESC>viwUi
" nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
if has('nvim')
    nnoremap <silent> <TAB> :bnext<CR>
    " SHIFT-TAB will go back
    nnoremap <silent> <S-TAB> :bprevious<CR>
else
    noremap <Tab> :bn<CR>
    noremap <S-Tab> :bp<CR>
    noremap <Leader><Tab> :Bw<CR>
    noremap <Leader><S-Tab> :Bw!<CR>
    noremap <C-t> :tabnew split<CR>

endif
" Move selected line / block of text in visual mode
" shift + k to move up
" shift + j to move down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Alternate way to save
nnoremap <silent> <C-s> :w<CR>
" Alternate way to quit
nnoremap <silent> <C-Q> :wqall!<CR>
" Use control-c instead of escape
nnoremap <silent> <C-c> <Esc>
" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Terminal window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <Esc> <C-\><C-n>

" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
cnoremap <C-j>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
cnoremap <C-k>          <Up>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*
" <C-g>: Exit.
cnoremap <C-g>          <C-c>

" noremap s <nop>
" nmap s <nop>
" split<silent> j below

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

noremap <leader>rc :e ~/.config/nvim/init.vim<cr>
noremap <leader>st :Startify<cr>
noremap <leader>dd :call CompileRunGcc()<CR>

if has('nvim')
    " find the file based on the file name
    noremap <C-p> :Telescope find_files<cr>
    " find file based on the content
    noremap <C-g> :Telescope live_grep<cr>
else
    noremap <C-p> :Leaderf file<cr>
    noremap <C-g> :Leaderf rg<cr>
endif

noremap Q :q!<cr>
noremap <c-q> :qall!<cr>
noremap X :xall!<cr>
noremap <c-S> :w!<cr>


nnoremap W 5w
nnoremap B 5b
nnoremap E 5e
let g:ranger_map_keys='Rg'
nnoremap <leader>o :ToggleOnly<Enter>
nnoremap <leader>C :ToggleCopy<Enter>

if has('nvim')
    nnoremap <M-x> :Maps<cr>
    nmap <M-r> <Plug>VimspectorRestart
    nmap <M-t> <Plug>VimspectorToggleBreakpoint
    nmap <M-n> <Plug>VimspectorStepOver
    nmap <M-o> <Plug>VimspectorStepOut
    nmap <M-i> <Plug>VimspectorStepInto
    nmap <M-c> <Plug>VimspectorContinue
    nmap <M-q> <Plug>VimspectorReset
    " for normal mode - the word under the cursor
    nmap <M-k> <Plug>VimspectorBalloonEval
    " for visual mode, the visually selected text
    xmap <M-k> <Plug>VimspectorBalloonEval
else
    execute "set <M-x>=\ex"
    execute "set <M-r>=\er"
    execute "set <M-t>=\et"
    execute "set <M-k>=\ek"
    execute "set <M-n>=\en"
    execute "set <M-o>=\eo"
    execute "set <M-i>=\ei"
    execute "set <M-c>=\ec"
    execute "set <M-q>=\eq"
    nmap <M-x> :Maps<cr>
    nmap <M-r> <Plug>VimspectorRestart
    nmap <M-t> <Plug>VimspectorToggleBreakpoint
    nmap <M-o> <Plug>VimspectorStepOut
    nmap <M-i> <Plug>VimspectorStepInto
    nmap <M-c> <Plug>VimspectorContinue
    nmap <M-q> <Plug>VimspectorReset
    nmap <M-n> <Plug>VimspectorStepOver
    " for normal mode - the word under the cursor
    nmap <M-k> <Plug>VimspectorBalloonEval
    " for visual mode, the visually selected text
    xmap <M-k> <Plug>VimspectorBalloonEval
endif
