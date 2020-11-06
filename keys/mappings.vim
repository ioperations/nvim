" Basic Key Mappings

imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l
" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

if exists('g:vscode')

  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>

else

  " Better nav for omnicomplete
  inoremap <expr> <c-j> ("\<C-n>")
  inoremap <expr> <c-k> ("\<C-p>")

  " I hate escape more than anything else
  inoremap jk <Esc>
  inoremap kj <Esc>

  " Easy CAPS
  " inoremap <c-u> <ESC>viwUi
  " nnoremap <c-u> viwU<Esc>

  " TAB in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>
  " SHIFT-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

  " Move selected line / block of text in visual mode
  " shift + k to move up
  " shift + j to move down
  xnoremap K :move '<-2<CR>gv-gv
  xnoremap J :move '>+1<CR>gv-gv

  " Alternate way to save
  nnoremap <silent> <C-s> :w<CR>
  " Alternate way to quit
  nnoremap <silent> <C-Q> :wq!<CR>
  " Use control-c instead of escape
  nnoremap <silent> <C-c> <Esc>
  " <TAB>: completion.
  inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

  " Better window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " Terminal window navigation
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>

  " Use alt + hjkl to resize windows
  " nnoremap <silent> <M-j>    :resize -2<CR>
  " nnoremap <silent> <M-k>    :resize +2<CR>
  " nnoremap <silent> <M-h>    :vertical resize -2<CR>
  " nnoremap <silent> <M-l>    :vertical resize +2<CR>

  " split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
  " spilt k up
  " map s <nop>
  noremap s <nop>
  " nmap s <nop>
  nnoremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
  " split<silent> j below
  nnoremap sj :set splitbelow<CR>:split<CR>
  nnoremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
  nnoremap sl :set splitright<CR>:vsplit<CR>

  " Resize splits with arrow keys
  noremap <up> :res +5<CR>
  noremap <down> :res -5<CR>
  noremap <left> :vertical resize-5<CR>
  noremap <right> :vertical resize+5<CR>
endif

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

noremap <leader>rc :e ~/.config/nvim/init.vim<cr>
noremap <leader>st :Startify<cr>
noremap <leader>dd :call CompileRunGcc()<CR>

" find the file based on the file name
noremap <C-p> :FZF<cr>
" find file based on the content
noremap <C-g> :Rg<cr>

noremap <C-l> :TagbarToggle<cr>

noremap Q :q!<cr>
noremap S :w!<cr>

nnoremap <expr><C-d> coc#float#has_float() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <expr><C-u> coc#float#has_float() ? coc#float#scroll(0) : "\<C-u>"

nnoremap W 5w
nnoremap B 5b
nnoremap E 5e
