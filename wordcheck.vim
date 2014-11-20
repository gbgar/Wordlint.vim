" wordcheck.vim
" For use with wordcheck redundancy checker:
" https://github.com/gbgar/wordcheck
" Blake Gardner
" WTFPL 2014

"quit if wordcheck is not installed
if !executable("wordcheck")
        finish
end

"set default wordcheck_opts if none are provided by the user
if !exists("g:wordcheck_opts")
        let g:wordcheck_opts = '-t line'
endif

"check entire buffer and set location list
function! WordcheckBufferCheck()
        call setloclist(0,[])
        let dictlist = []
        luafile WordcheckVimBuffer.lua
        call setloclist(0,dictlist)
endfunction 
                                                      
command! WordcheckCheckBuffer call WordcheckBufferCheck()
