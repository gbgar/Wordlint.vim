" util.vim autoloading file, for shared functions
" BG 
" WTFPL 2014

function! wordlint#util#WordlintFloatToString(dictlist)
        " Convert floating lnum to integer,
        " necessary due to intransigent lua math
        for x in a:dictlist
                do
                let x.lnum = float2nr(x.lnum)
        endfor
        return a:dictlist
endfunction

function! wordlint#util#WordlintHighlightSyntax(dictlist)
        " Highlight matches using syntax coloring system.
        if g:wordlint_highlight != 0
               call clearmatches()
               for dic in a:dictlist
                 let line = dic.lnum
                 let col0 = col([line,dic.col])
                 let txt = dic.text
                 let wordlen = strlen(txt)
                 let highlight_list = [[line, col0, wordlen]]
                 call matchaddpos(g:wordlint_custom_highlight_group, highlight_list)
                endfor
        endif
endfunction

let s:plugluapath = expand('<sfile>:p:h:h:h') . "/lua/"
function! wordlint#util#WordlintExecuteLuaFile(file,optrange)
        " let plugluapath = printf('%s/lua/' . a:file, expand('<sfile>:h:h'))
        " echom s:plugluapath
        " echo fnameescape(plugluapath)
        " echo fnameescape(printf('%s/lua/' . a:file, expand('<sfile>p:h:h')))
        if a:optrange == 0
                execute "luafile " fnameescape(s:plugluapath . a:file)
        elseif a:optrange == 1 
                execute "%luafile " fnameescape(s:plugluapath . a:file)
        else
                execute "'<,'>luafile " fnameescape(s:plugluapath . a:file)
        endif
endfunction
