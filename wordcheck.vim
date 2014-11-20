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

"set default wordcheck_highlight  to true if not provided
if !exists("g:wordcheck_highlight")
        let g:wordcheck_highlight = 1
endif

"set default highlight group if no custom group is given
if !exists("g:wordcheck_custom_highlight_group")
        let g:wordcheck_custom_highlight_group = "Error"
endif

"check entire buffer and set location list
function! WordcheckBufferCheck()
        call setloclist(0, [])
        let dictlist = []
        luafile WordcheckVimBuffer.lua
        call setloclist(0, dictlist)
        call s:WordcheckHighlightSyntax(dictlist)
endfunction 

"function to highlight matches
function! s:WordcheckHighlightSyntax(dictlist)
        if g:wordcheck_highlight != 0
               call clearmatches()
               for dic in a:dictlist
                 let line = dic.lnum
                 let col0 = col([line,dic.col])
                 let wordlen = strlen(dic.text)
                 let hlist = [[line, col0, wordlen]]
                 call matchaddpos(g:wordcheck_custom_highlight_group, hlist)
                endfor
        endif
endfunction

command! WordcheckCheckBuffer call WordcheckBufferCheck()
