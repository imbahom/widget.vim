
function! s:ClearExtraSpaceAndIndent()
    let curLineNumber=line(".")
    let curColNumber=col(".")
    silent! %s/\s*$//
    silent! normal gg=G
    call cursor(curLineNumber,curColNumber)
    silent! normal zz
endfunction

" todo
" lua , c/c++
fu! s:selectParagraph(dir) abort
    let s:DIR_UP = 0x01
    let s:DIR_DOWN = 0x10
    if a:dir == s:DIR_UP
        " normal {}kV^%
        normal [[V][
    elseif a:dir == s:DIR_DOWN
        " normal }{jV^%
        normal ][V[[
    endif
    unlet s:DIR_DOWN
    unlet s:DIR_UP
endf!

fu! s:hexEditingSwitcher(yes) abort
    if a:yes == 1
        exe "%!xxd"
    else
        exe "%!xxd -r"
    endif
endf!

fu! s:runCurFileWithCmd(cmd)
    execute "w"
    " execute " !clear;".a:cmd." ".expand("%")
    execute "!clear;".a:cmd." %"
endf!

vnoremap  <F2>        :!column -t<CR>\
            \:call  <SID>ClearExtraSpaceAndIndent()<CR>
nnoremap  <F2>        :call  <SID>ClearExtraSpaceAndIndent()<CR>
nnoremap  <Leader>vd  :call  <SID>selectParagraph(0x10)<CR>
nnoremap  <Leader>vu  :call  <SID>selectParagraph(0x01)<CR>
nnoremap  <F1>        :help  <c-r>=expand("<cword>")<CR><CR>
nnoremap  <Leader>hy  :call  <SID>hexEditingSwitcher(1)<CR>
nnoremap  <Leader>hn  :call  <SID>hexEditingSwitcher(0)<CR>

au  FileType  ruby    nnoremap  <F5>  :call  <SID>runCurFileWithCmd("ruby")<CR>
au  FileType  lua     nnoremap  <F5>  :call  <SID>runCurFileWithCmd("lua")<CR>
au  FileType  go      nnoremap  <F5>  :call  <SID>runCurFileWithCmd("go run")<CR>
au  FileType  python  nnoremap  <F5>  :call  <SID>runCurFileWithCmd("python")<CR>


