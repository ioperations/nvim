
" gvim
if(has("gui"))
    " 禁止光标闪烁
    set gcr=a:block-blinkon0
    " 禁止显示滚动条
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    " 禁止显示菜单和工具条
    set guioptions-=m
    set guioptions-=T
    set guifont=Monaco
endif


let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
    let has_machine_specific_file = 0
    silent! exec "!cp ~/.config/nvim/general/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
    if has("macunix")
        silent! exec "!ln -sv ~/.config/nvim/general/coc-settings.json.macos ~/.config/nvim/coc-settings.json"
    elseif has('unix')
        silent! exec "!ln -sv ~/.config/nvim/general/coc-settings.json.linux ~/.config/nvim/coc-settings.json"
    endif
endif
source ~/.config/nvim/_machine_specific.vim

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ~/.config/nvim/_machine_specific.vim"
endif

if (exists('g:loadLangtemplate'))
    source ~/.config/nvim/general/langtemplate.vim
    let g:loadLangtemplate = 1
endif

" Better nav for omnicomplete TODO figure out why this is being overridden
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
"inoremap <C-h> <left>
"inoremap <C-l> <right>
"
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

autocmd BufEnter *.c set iskeyword-=-
autocmd BufEnter *.cpp set iskeyword-=-
autocmd BufEnter *.cc set iskeyword-=-

" make background transparent
"hi Normal guibg=NONE ctermbg=NONE
