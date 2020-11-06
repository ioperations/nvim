function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else    
    execute "'<,'>Commentary"
 endif
 endfunction
noremap <silent> <space>cc :call Comment()<cr>
