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
  nnoremap <silent> <C-Q> :wqall!<CR>
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

  " split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
  " spilt k up
  " map s <nop>
  " noremap s <nop>
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

" noremap <C-l> :TagbarToggle<cr>
noremap <c-l> :Vista coc<cr>

noremap Q :q!<cr>
noremap <c-q> :qall!<cr>
noremap X :xall!<cr>
noremap <c-S> :w!<cr>


nnoremap W 5w
nnoremap B 5b
nnoremap E 5e
" Actions
" let g:fzf_action = {
" \ 'alt-j': 'preview-down',
" \ 'alt-k': 'preview-up',
" \ 'alt-o': '!open'}
" Search spotlight {{{2
" command! -nargs=1 FzfSpotlight call fzf#run(fzf#wrap({
" \ 'source'  : 'mdfind -onlyin ~ <q-args>',
" \ 'options' : '-m --prompt "Spotlight> "'
" \ }))
" nnoremap <Space>s :FzfSpotlight <C-R><C-W>
let g:ranger_map_keys='Rg'
