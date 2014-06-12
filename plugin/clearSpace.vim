
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

let s:DIR_UP = 'DIR_UP'
let s:DIR_DOWN = 'DIR_DOWN'
fu! s:selectParagraph(dir)
    silent! call ClearExtraSpace()
    if a:dir == s:DIR_UP
        silent! normal {jV^%
    elseif a:dir == s:DIR_DOWN
        silent! normal }kV^%
    endif
endf!

noremap <Leader>vd :call <SID>selectParagraph('DIR_DOWN')<CR>
noremap <Leader>vu :call <SID>selectParagraph('DIR_UP')<CR>
