if !executable("wordcheck")
        finish
end

if !exists("g:wordcheck_opts")
        let g:wordcheck_opts = '-t line'
endif

function! WordcheckBufferCheck()
        call setloclist(0,[])
        let dictlist = []
        luafile WordcheckVimBuffer.lua
        call setloclist(0,dictlist)
endfunction 
                                                      
command! WordcheckCheckBuffer call WordcheckBufferCheck()
