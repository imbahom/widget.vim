
function! ClearExtraSpaceAndIndent()
    let curLineNumber=line(".")
    let curColNumber=col(".")
    silent! %s/\s*$//
    silent! normal gg=G
    call cursor(curLineNumber,curColNumber)
    silent! normal zz
endfunction

let s:DIR_UP = 'DIR_UP'
let s:DIR_DOWN = 'DIR_DOWN'
fu! s:selectParagraph(dir)
    call ClearExtraSpaceAndIndent()
    if a:dir == s:DIR_UP
        normal {}kV^%
    elseif a:dir == s:DIR_DOWN
        normal }{jV^%
    endif
endf!

vnoremap <F2>        :!column -t<CR> :call ClearExtraSpaceAndIndent<CR>
noremap  <F2>        :call  ClearExtraSpaceAndIndent<CR>
noremap  <Leader>vd  :call  <SID>selectParagraph('DIR_DOWN')<CR>
noremap  <Leader>vu  :call  <SID>selectParagraph('DIR_UP')<CR>
noremap  <F1>        :help  <c-r>=expand("<cword>")<CR><CR>

