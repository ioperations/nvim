func! Setupmarkdown()
	autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
	autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>c5l<CR>
	autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
	autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
	autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
	autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
	autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
	autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
	autocmd Filetype markdown inoremap <buffer> ,m - [ ] <Enter><++><ESC>kA
	autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
	autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
	autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
endfunction


func! Setupshell()
	call append(0,["#!/usr/bin/env sh",
				\ "ccred=\"\\033[0;31m\"", 
				\ "ccgreen=\"\\033[0;32m\"",    
				\ "ccyellow=\"\\033[0;33m\"",   
				\ "ccwhite=\"\\033[0;37m\"",    ])
endfunction

function! Setupmake()
	call append(0,["#!/usr/bin/env make",
				\ "ccred=$(shell echo \"\\033[0;31m\")",
				\ "ccgreen=$(shell echo \"\\033[0;32m\")",
				\ "ccyellow=$(shell echo \"\\033[0;33m\")",
				\ "ccwhite=$(shell echo \"\\033[0;37m\")",
				\ "# $(error ${ccred} error message ${ccwhite})",
				\ "# $(info ${ccyellow} info message ${ccwhite})",
				\ "",
				\ "",
				\ "#check if file exists",
				\ "#ifneq (\"$(wildcard  FILENAME)\",\"\")",
				\ "##file exists; use space insted of tab here",
				\ "#endif ",
				\ "",
				\ "#use ${LINENO} to locate the error message location",
				\ "",
				\ "",
				\ "",
				\ "cmake:",
				\ "\tcmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..",])

endfunction

function! Setuppython()
	call append(0,["#!/usr/bin/env python3"])
	
endfunction

function! SetupCppTest()
	call append(0,["#include <iostream>",
				\ "#include <gtest/gtest.h>",
				\ "",
				\ "TEST(testName,testNum){",
				\ "",
				\ "}",
				\ "",
				\ "int main(int argc, char *argv[])",
				\ "{",
				\ "    testing::InitGoogleTest(&argc,argv);",
				\ "    return RUN_ALL_TESTS();",
				\ "}",])
endfunction

function! SetupGoTest()
	call append(0,[ "",
				\"import (",
				\"     \"testing\"",
				\")",
				\"",
				\"",
				\"func TestExample(t *testing.T) {",
				\"",
				\"      t.Errorf(\"not ok\")",
				\"}",
				\"",
				\"",
				\"func TestMain(t *testing.M) {",
				\"      t.Run()",
				\"}",])
endfunction

function! SetupCppBench()
	call append(0,["#include <benchmark/benchmark.h>",
				\ "",
				\ "static void BM_StringCreation(benchmark::State& state) {",
				\ "for (auto _ : state)",
				\ "    std::string empty_string;",
				\ "}",
				\ "// Register the function as a benchmark",
				\ "BENCHMARK(BM_StringCreation);",
				\ "",
				\ "// Define another benchmark",
				\ "static void BM_StringCopy(benchmark::State& state) {",
				\ "    std::string x = \"hello\";",
				\ "    for (auto _ : state){",
				\ "        std::string copy(x);",
				\ "    }",
				\ "}",
				\ "",
				\ "BENCHMARK(BM_StringCopy);",
				\ "",
				\ "BENCHMARK_MAIN();",])

endfunction


autocmd BufNewFile *_test.cpp call SetupCppTest()
autocmd BufNewFile *_bench.cpp call SetupCppBench()
autocmd BufNewFile *.sh call Setupshell()
autocmd BufNewFile Makefile call Setupmake()
autocmd BufNewFile *.py call Setuppython()
autocmd BufNewFile *_test.go call SetupGoTest()
autocmd Filetype markdown call Setupmarkdown()
