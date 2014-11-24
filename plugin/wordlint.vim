" wordlint.vim
" For use with wordlint redundancy checker:
" https://github.com/gbgar/Wordlint
" Blake Gardner
" WTFPL 2014

" quit if wordlint program is not available
if !executable("wordlint")
        finish
end

" set default wordlint_opts to empty string if none are provided by the user
if !exists("g:wordlint_opts")
        let g:wordlint_opts = ' '
endif

" set default wordlint_highlight  to true if not provided
if !exists("g:wordlint_highlight")
        let g:wordlint_highlight = 1
endif

" set default highlight group if no custom group is given
if !exists("g:wordlint_custom_highlight_group")
        let g:wordlint_custom_highlight_group = "Error"
endif

function! WordlintBufferCheck()
" lint entire buffer, set loc. list[, and highlight].
        call setloclist(0, [])
        let g:dictlist = []
        " Lua cannot utilize pipes in the standard library therefore, wordlint
        " must receive a file name.  In case no file name is present or the
        " bufer has changed, pass entire file to  lua script that processes
        " selection
        if filereadable(expand('%:p')) && b:changedtick == 0
        call wordlint#util#WordlintExecuteLuaFile("WordlintVimBuffer.lua",0)
        else
        call wordlint#util#WordlintExecuteLuaFile("WordlintVimSelection.lua",1)
        let g:dictlist = wordlint#util#WordlintFloatToString(g:dictlist)
        endif
        call setloclist(0, g:dictlist)
        call wordlint#util#WordlintHighlightSyntax(g:dictlist)
        unlet g:dictlist
endfunction 

function! WordlintSelectedCheck() range
" Check contents of visual selection, set loc. list[, and lint highlight].
        call setloclist(0, [])
        let g:dictlist = []
        let lineone = a:firstline
        let linelast = a:lastline
        call wordlint#util#WordlintExecuteLuaFile("WordlintVimSelection.lua",3)
        " luafile WordlintVimSelection.lua
        let g:dictlist = wordlint#util#WordlintFloatToString(g:dictlist)
        call setloclist(0, g:dictlist)
        call wordlint#util#WordlintHighlightSyntax(g:dictlist)
        unlet lineone
        unlet linelast
        unlet g:dictlist
endfunction

command! WordlintCheckBuffer silent call WordlintBufferCheck()
command! -range=% WordlintCheckSelected silent <line1>,<line2>call WordlintSelectedCheck()
