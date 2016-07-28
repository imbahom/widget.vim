if exists("g:loaded_widget")
    finish
endif
let g:loaded_widget = 1

function! s:ClearExtraSpaceAndIndent()
    let curLineNumber=line(".")
    let curColNumber=col(".")
    silent! %s/\s*$//

    silent! normal gg=G
    call cursor(curLineNumber,curColNumber)
    silent! normal zz
endfunction


fu! s:hexEditingSwitcher(yes) abort
    if a:yes == 1
        exe "%!xxd"
    else
        exe "%!xxd -r"
    endif
endf!

fu! s:runCurFileWithCmd(cmd,ignoreCurFile)
    execute "w"
    " strpart(cmd,0,1)
    let cmd = a:cmd
    let pre = ""
    if char2nr(a:cmd) == char2nr("!")
        if !has("gui_running")
            let pre = "!clear;"
        endif
    endif
    if pre == "!clear;" && strpart(cmd,0,1) == "!"
        let cmd = strpart(cmd,1,strlen(cmd)-1)
    endif

    if a:ignoreCurFile == 1
        execute pre.cmd
    else
        execute pre.cmd." %"
    endif
    unl! cmd
    unl! pre
endf!

vnoremap  <F2>        :!column -t<CR>\
            \:call  <SID>ClearExtraSpaceAndIndent()<CR>
nnoremap  <F2>        :call  <SID>ClearExtraSpaceAndIndent()<CR>
nnoremap  <leader>vd  :call  <SID>selectParagraph(0x10)<CR>
nnoremap  <leader>vu  :call  <SID>selectParagraph(0x01)<CR>
nnoremap  <F1>        :help  <c-r>=expand("<cword>")<CR><CR>
nnoremap  <leader>hy  :call  <SID>hexEditingSwitcher(1)<CR>
nnoremap  <leader>hn  :call  <SID>hexEditingSwitcher(0)<CR>


" mv to vimrc
au  FileType  ruby    nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!ruby",0)<CR>
au  FileType  lua     nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!lua",0)<CR>
au  FileType  javascript     nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!node",0)<CR>
au  FileType  go      nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!go run",0)<CR>
au  FileType  python  nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!python3",0)<CR>
au  FileType  cpp     nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!g++ %;./a.out",1)<CR>
au  FileType  c       nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!gcc %;./a.out",1)<CR>
au  FileType  java    nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!javac %;java %:r",1)<CR>
au  FileType  sh      nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!sh",0)<CR>
au  FileType  zsh      nnoremap  <F5>  :call  <SID>runCurFileWithCmd("!zsh",0)<CR>
" au  FileType  vimwiki nnoremap  <F5>  :call  <SID>runCurFileWithCmd("Vimwiki2HTML",1)<CR>
au  FileType  vimwiki nnoremap  <F5>  :call  <SID>runCurFileWithCmd("VimwikiAll2HTML",1)<CR>
au  FileType  vimwiki nnoremap  <F10>  :call  <SID>runCurFileWithCmd("Vimwiki2HTMLBrowse",1)<CR>
au  FileType  vim     nnoremap  <F5>  :call  <SID>runCurFileWithCmd("source",0)<CR>
