" Random Useful Functions

" Turn spellcheck on for markdown files
augroup auto_spellcheck
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        " mac has some limit
        if has("macunix")
            exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 clang % -DTEST_ADQ -I /usr/local/opt/llvm/include/c++/v1/ -g -fsanitize=address -lm -g -Wall -o %< && time ./%<"
        elseif has("unix")
            exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 clang % " . DotenvGet('CLANG_C_FLAGS') . " -g -o %< && time timeout 30 ./%<"
        endif
    elseif &filetype == 'cpp'
        set splitbelow
        if has("macunix")
            exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 clang++ -DTEST_ADQ -I /usr/local/opt/llvm/include/c++/v1/ -g -std=c++2a %  -fsanitize=address -lm -Wall -o %< && time ./%<"
        elseif has("unix")
            exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 clang++ % " . DotenvGet('CLANG_CXX_FLAGS') . " -g -o %< && time timeout 30 ./%<"
        endif
    elseif &filetype == 'cuda'
        set splitbelow
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 nvcc -g -std=c++11 %  -o %< && timeout 30 ./%<"
    elseif &filetype == 'haskell'
        set splitbelow
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 ghc % -o %< && timeout 30 ./%<"
    elseif &filetype == 'java'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 javac -encoding utf8 % && time timeout 30 java %< "
    elseif &filetype == 'sh'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 time zsh %"
    elseif &filetype == 'python'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 time python3 %"
    elseif &filetype == 'html'
        silent! exec "!/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome % "
    elseif &filetype == 'javascript'
        exec "!node %"
    elseif &filetype == 'swift'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 swiftc % -o %< && timeout 20 ./%<"
    elseif &filetype == 'typescript'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 timeout 30 node %"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        :StartLatexPreview
        " silent! exec "!pdflatex %"
        " silent! exec "!echo 'done'"
        "silent! exec "VimtexCompile"
    elseif &filetype == 'rust'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 cargo build && timeout 30 cargo run"
    elseif &filetype == 'go'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 timeout 30 go run %"
    elseif &filetype == 'lua'
        exec "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 timeout 30 lua %"
    endif
endfunc


