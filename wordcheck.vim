" wordcheck.vim
" For use with wordcheck redundancy checker:
" https://github.com/gbgar/wordcheck
" Blake Gardner
" WTFPL 2014

" quit if wordcheck is not installed
if !executable("wordcheck")
        finish
end

" set default wordcheck_opts if none are provided by the user
if !exists("g:wordcheck_opts")
        let g:wordcheck_opts = '-t line'
endif

" set default wordcheck_highlight  to true if not provided
if !exists("g:wordcheck_highlight")
        let g:wordcheck_highlight = 1
endif

" set default highlight group if no custom group is given
if !exists("g:wordcheck_custom_highlight_group")
        let g:wordcheck_custom_highlight_group = "Error"
endif

function! WordcheckBufferCheck()
" check entire buffer, set loc. list[, and highlight].
        call setloclist(0, [])
        let dictlist = []
        " Lua cannot utilize pipes in the standard library
        " therefore, wordcheck must receive a file name.
        " In case no file name is present, pass entire
        " file to  lua script that processes selection
        if filereadable(expand('%:p'))
        luafile WordcheckVimBuffer.lua
        else
        %luafile WordcheckVimSelection.lua
        let dictlist = s:WordcheckFloatToString(dictlist)
        endif
        call setloclist(0, dictlist)
        call s:WordcheckHighlightSyntax(dictlist)
endfunction 

function! WordcheckSelectedCheck() range
" Check contents of visual selection, set loc. list[, and check highlight].
        call setloclist(0, [])
        let dictlist = []
        let lineone = a:firstline
        let linelast = a:lastline
        '<,'>luafile WordcheckVimSelection.lua  "sets list of dictionaries
        let dictlist = s:WordcheckFloatToString(dictlist)
        call setloclist(0, dictlist)
        call s:WordcheckHighlightSyntax(dictlist)
        unlet lineone
        unlet linelast
endfunction

function! s:WordcheckFloatToString(dictlist)
        " Convert floating lnum to integer,
        " necessary due to intransigent lua math
        for x in a:dictlist
                do
                let x.lnum = float2nr(x.lnum)
        endfor
        return a:dictlist
endfunction

function! s:WordcheckHighlightSyntax(dictlist)
        " Highlight matches using syntax coloring system.
        if g:wordcheck_highlight != 0
               call clearmatches()
               for dic in a:dictlist
                 let line = dic.lnum
                 let col0 = col([line,dic.col])
                 let txt = dic.text
                 let wordlen = strlen(txt)
                 let highlight_list = [[line, col0, wordlen]]
                 call matchaddpos(g:wordcheck_custom_highlight_group, highlight_list)
                endfor
        endif
endfunction

command! WordcheckCheckBuffer call WordcheckBufferCheck()
command! -range WordcheckCheckSelected silent <line1>,<line2>call WordcheckSelectedCheck()
