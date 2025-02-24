-- ########################################################################
-- Custom Functions
-- ########################################################################

-- Toggle the sign column
function ToggleSignColumn()
    if vim.wo.signcolumn == "no" then
        vim.wo.signcolumn = "yes"
    else
        vim.wo.signcolumn = "no"
    end
end

-- Toggle text width bar (color column)
function ToggleTextWidth()
    if vim.wo.colorcolumn == "" then
        vim.wo.colorcolumn = "60,80"
    else
        vim.wo.colorcolumn = ""
    end
end

-- Toggle relative line numbers
function ToggleRelativeLineNumbers()
    vim.wo.relativenumber = not vim.wo.relativenumber
end

-- Toggle indenting with tabs and spaces
function ToggleIndentType()
    vim.bo.expandtab = not vim.bo.expandtab
end

-- Get list of buffers
function GetBufferList()
    return vim.api.nvim_exec("ls!", true)
end

-- Toggle the quickfix or location list menu
function ToggleList(bufname, pfx)
    local buflist = GetBufferList()
    for bufnum in string.gmatch(buflist, "(%d+)") do
        bufnum = tonumber(bufnum)
        if vim.fn.bufwinnr(bufnum) ~= -1 then
            vim.cmd(pfx .. "close")
            return
        end
    end
    vim.cmd(pfx .. "open")
end

-- ########################################################################
-- Key Mappings
-- ########################################################################

local opts = { noremap = true, silent = true }

-- Window navigation
vim.keymap.set("n", "<C-j>", "<C-W><C-J>", opts)
vim.keymap.set("n", "<C-k>", "<C-W><C-K>", opts)
vim.keymap.set("n", "<C-l>", "<C-W><C-L>", opts)
vim.keymap.set("n", "<C-h>", "<C-W><C-H>", opts)
vim.keymap.set("n", "<Left>", ":2 wincmd <<CR>", opts)
vim.keymap.set("n", "<Right>", ":2 wincmd ><CR>", opts)
vim.keymap.set("n", "<Up>", ":2 wincmd +<CR>", opts)
vim.keymap.set("n", "<Down>", ":2 wincmd -<CR>", opts)

-- Navigate wrapped lines
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("n", "j", "gj", opts)

-- Toggle commands
vim.keymap.set("n", "<Leader>sc", ToggleSignColumn, opts)
vim.keymap.set("n", "<Leader>wr", ":set wrap!<CR>", opts)
vim.keymap.set("n", "<Leader>hl", ":set hlsearch!<CR>", opts)
vim.keymap.set("n", "<Leader>t", ToggleIndentType, opts)
vim.keymap.set("n", "<Leader><Leader>rn", ToggleRelativeLineNumbers, opts)
vim.keymap.set("n", "tw", ToggleTextWidth, opts)
vim.keymap.set("n", "<Space>", "za", opts)
vim.keymap.set("v", "<Space>", "za", opts)

-- Buffer and Window Management
vim.keymap.set("n", "<Leader>n", ":bn<CR>", opts)
vim.keymap.set("n", "<Leader>p", ":bp<CR>", opts)
vim.keymap.set("n", "<Leader>vp", ":vsplit<CR>", opts)
vim.keymap.set("n", "<Leader>hp", ":split<CR>", opts)
vim.keymap.set("n", "<Leader>vs", ":vertical resize +", opts)
vim.keymap.set("n", "<Leader>hs", ":resize +", opts)

-- Move visually selected lines up and down
vim.keymap.set("v", "J", ":move '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":move '<-2<CR>gv=gv", opts)

-- Window layout adjustments
vim.keymap.set("n", "<Leader>ah", "<C-W>H", opts)
vim.keymap.set("n", "<Leader>aj", "<C-W>J", opts)
vim.keymap.set("n", "<Leader>ak", "<C-W>K", opts)
vim.keymap.set("n", "<Leader>al", "<C-W>L", opts)

-- Folding
vim.keymap.set("n", "<Leader>f", "zR", opts)
vim.keymap.set("n", "<Leader>g", "zM", opts)

-- Miscellaneous
vim.keymap.set("n", "<Leader>r", ":source ~/.config/nvim/init.lua<CR>", opts)
vim.keymap.set("n", "<Leader>pwf", ":echo expand('%p')<CR>", opts)

-- Sort surrounding characters
vim.keymap.set("n", "ss{", "vi{:sort<CR>", opts)
vim.keymap.set("n", "ss(", "vi(:sort<CR>", opts)
vim.keymap.set("n", "ss<", "vi<:sort<CR>", opts)
vim.keymap.set("n", "ss[", "vi[:sort<CR>", opts)

-- Delete trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

-- Search for visually selected text using `//`
vim.keymap.set("v", "//", 'y/\\V<C-R>"<CR>', opts)

-- Search next occurrence without jumping
vim.keymap.set("n", "*", "*N", opts)

-- Make delimitMate play nicely with pop-up menu
vim.keymap.set("i", "<CR>", 'pumvisible() and "<C-Y>" or "<Plug>delimitMateCR"', { expr = true })

-- Exit insert mode with "jj", format file, then save
vim.keymap.set("i", "jj", "<ESC>:lua vim.lsp.buf.format()<CR>:w<CR>", opts)
