-- WordlintVimBuffer.lua
-- 
-- get default options and buffer name
wcoptions = vim.eval('g:wordlint_opts')
b = vim.buffer()
file = b.fname

-- return bufnr with vim.buffer().number returned as float,
-- producing an error on the vim side
bnum = vim.command"call bufnr(\'.\')"

-- get empty list from vim and run wordlint
wordpairlist = vim.eval('g:dictlist')

-- The command'wordlint -s vim..' produces lines of key-value pairs
-- with each pair of lines corresponding to a pair of words
-- matched by the program. 
wordpairs = io.popen("wordlint -s vim " .. wcoptions .. " -f " .. file)

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
        for x, y in string.gmatch(line, "(%w+)=\'(%g+)\'") do
                pairentry[x] = y
        end
        pairentry.filename = file
        pairentry.bufnr = bnum
        wordpairlist:add(pairentry)
    end
end
wordpairs:close()
