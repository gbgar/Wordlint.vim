" Vim compiler file
" Compiler: Wordlint
" Maintainer: GB Gardner 
" Last Change: 2014-11-29

if exists("current_compiler")
finish
endif
let current_compiler = "wordlint"

if exists(":CompilerSet") != 2	" older Vim always used :setlocal
command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=wordlint\ -f\ %:p\ -s\ error\ $*

CompilerSet errorformat=%f:%l:%m\n

if !exists("g:wordlint_opts")
        let g:wordlint_opts = " "
endif

command! Wordlint :execute "make" g:wordlint_opts<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
