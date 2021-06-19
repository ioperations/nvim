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
      exec "!clang % -DTEST_ADQ -fsanitize=address -lm -g -Wall -o %<"
    elseif has("unix")
      exec "!clang % -DTEST_ADQ -fsanitize=address -lgtest  -lbenchmark -pthread  -lcrypto -lpcre -g -Wall -o %<"
    endif
    exec "!timeout 30 ./%<"
  elseif &filetype == 'cpp'
    set splitbelow
    if has("macunix")
      exec "!clang++ -DTEST_ADQ -std=c++20 %  -fsanitize=address -lm -Wall -o %<"
    elseif has("unix")
      exec "!clang++ -DTEST_ADQ -std=c++20 %  -fsanitize=address -lgtest -lbenchmark -lcrypto -pthread -lpcre -g -Wall -o %<"
    endif
    exec "!timeout 30  ./%<"
  elseif &filetype == 'cuda'
    set splitbelow
    exec "!nvcc -std=c++11 %  -o %<"
    exec "!timeout 30 ./%<"
  elseif &filetype == 'java'
    exec "!javac -encoding utf8 %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    exec "!time python3 %"
  elseif &filetype == 'html'
    "silent! exec "!chromium % &"
    silent! exec "!/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome % "
  elseif &filetype == 'javascript'
    exec "!node %"
  elseif &filetype == 'swift'
    exec "!swiftc % -o %<"
    exec "!timeout 20 ./%<"
  elseif &filetype == 'typescript'
    exec "!node %"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'tex'
    :StartLatexPreview
    " silent! exec "!pdflatex %"
    " silent! exec "!echo 'done'"
    "silent! exec "VimtexCompile"
  elseif &filetype == 'rust'
    exec "!cargo build"
    exec "!cargo run"
  elseif &filetype == 'go'
    exec "!go run %"
  elseif &filetype == 'lua'
    exec "!lua %"
  endif
endfunc


