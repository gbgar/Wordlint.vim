-- WordcheckVimSelection.lua
-- 
-- get default options and buffer name
wcoptions = vim.eval('g:wordcheck_opts')
b = vim.buffer()

-- return bufnr with vim.buffer().number returned as float,
-- producing an error on the vim side
jbnum = vim.command"call bufnr(\'.\')"

-- get empty list from vim and run wordcheck
wordpairlist = vim.eval('dictlist')

-- get range text

vistext = ""
fl = vim.firstline
ll = vim.lastline
linedif = ll - fl
local fname = os.tmpname()
local handle = io.open(fname, "w+")
for l=1, linedif do
    local m = l - 1
    local n = fl + m
    local newl = b[n] .. "\n"
    handle:write(newl)
end
-- The command'wordcheck -s vim..' produces lines of key-value pairs
-- with each pair of lines corresponding to a pair of words
-- matched by the program. 
wordpairs = io.popen("wordcheck -s vim " .. wcoptions .. " -f " .. fname)
-- wordpairs = vim.command"call system(\"wordcheck \" . g:wordcheck_opts,)"
-- The following iterates through this output line by line,
-- translating each (with some additions) into a dictionary 
-- and producing a list of dictionaries corresponding to a
-- list of matched words for use in setloclist().
for line in wordpairs:lines() do
        pairentry = vim.dict()
-- only add new dict if not a blank line
    if line ~= "" then
        -- pattern matching info:
        -- http://www.lua.org/manual/5.2/manual.html#6.4.1
        -- http://pgl.yoyo.org/luai/i/string.gmatch
        for x, y in string.gmatch(line, "(%w+)=\'([%s%g]*)\'") do
                pairentry[x] = y
        end
        pairentry["lnum"] = pairentry["lnum"] + fl - 1
        pairentry.bufnr = bnum
        wordpairlist:add(pairentry)
    end
end
wordpairs:close()
io.close(handle)
