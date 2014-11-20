wcoptions = vim.eval('g:wordcheck_opts')
file = b.fname
-- because vim.buffer().number returned as float,
-- returning an error on the vim side
bnum = vim.command"call bufnr(\'.\')"
wordpairlist = vim.eval('dictlist')
wordpairs = io.popen("wordcheck -s vim " .. wcoptions .. " -f " .. file)
for line in wordpairs:lines() do
        pairentry = vim.dict()
        for x, y in string.gmatch(line, "(%w+)=\'([%w%s]*)\'") do
                pairentry[x] = y
        end
        pairentry.filename = file
        pairentry.bufnr = bnum
        wordpairlist:add(pairentry)
end
wordpairs:close()
