function! ClearExtraSpace()
    let curLineNumber=line(".")
    let curColNumber=col(".")
    silent! %s/\s*$//
    silent! normal gg=G
    call cursor(curLineNumber,curColNumber)
    silent! normal zz
endfunction

silent! command! ClearSpaceAndIndent call ClearExtraSpace()
noremap <F2> :ClearSpaceAndIndent<CR>

vnoremap <F2> :!column -t <CR> :ClearSpaceAndIndent<CR>

noremap <Leader>vd }kV{j
noremap <Leader>vu {jV}k
