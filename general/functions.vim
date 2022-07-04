" Random Useful Functions

" Turn spellcheck on for markdown files
augroup auto_spellcheck
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

func! CompileRunGcc()
    let container = "AsyncRun -position=bottomright -pos=floaterm -mode=term -width=0.6 -height=0.6 "
    exec "w"
    if &filetype == 'c'
        " mac has some limit
        if has("macunix")
            exec container . " clang % -DTEST_ADQ -I /usr/local/opt/llvm/include/c++/v1/ " . DotenvGet('CLANG_C_FLAGS') . " -g -fsanitize=address -lm -g -Wall -Wpedantic -o %< && time ./%<"
        elseif has("unix")
            exec container . " clang % " . DotenvGet('CLANG_C_FLAGS') . " -Wall -Wpedantic -g -o %< && time timeout 30 ./%<"
        endif
    elseif &filetype == 'cpp'
        set splitbelow
        if has("macunix")
            exec container . " clang++ -DTEST_ADQ -I /usr/local/opt/llvm/include/c++/v1/ -g -std=c++17 %  -fsanitize=address  -Wall -Wpedantic " . DotenvGet('CLANG_CXX_FLAGS') . " -o %< && time ./%<"
        elseif has("unix")
            exec container . " clang++ % " . DotenvGet('CLANG_CXX_FLAGS') . " -Wall -Wpedantic -g -o %< && time timeout 30 ./%<"
        endif
    elseif &filetype == 'cuda'
        set splitbelow
        exec container . " nvcc -g -std=c++11 %  -o %< && timeout 30 ./%<"
    elseif &filetype == 'haskell'
        set splitbelow
        exec container . " ghc % -o %< && timeout 30 ./%<"
    elseif &filetype == 'java'
        exec container . " javac -encoding utf8 % && time timeout 30 java %< "
    elseif &filetype == 'sh'
        exec container . " time bash %"
    elseif &filetype == 'zsh'
        exec container . " time zsh %"
    elseif &filetype == 'python'
        exec container . " time python3 %"
    elseif &filetype == 'html'
        silent! exec "!/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome % "
    elseif &filetype == 'javascript'
        exec "!node %"
    elseif &filetype == 'swift'
        exec container . " swiftc % -o %< && timeout 20 ./%<"
    elseif &filetype == 'typescript'
        exec container . " timeout 30 node %"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        :StartLatexPreview
        " silent! exec "!pdflatex %"
        " silent! exec "!echo 'done'"
        "silent! exec "VimtexCompile"
    elseif &filetype == 'rust'
        exec container . " cargo build && timeout 30 cargo run"
    elseif &filetype == 'go'
        exec container . " timeout 30 go run %"
    elseif &filetype == 'lua'
        exec container . " timeout 30 lua %"
    endif
endfunc


