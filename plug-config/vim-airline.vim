if has('nvim')
    let g:airline#extensions#tabline#enabled = 0
else
    let g:airline#extensions#tabline#formatter = 'default'
    let g:airline#extensions#tabline#enabled = 1
endif
