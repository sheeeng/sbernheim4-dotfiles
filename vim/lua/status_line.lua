-- Define left and right separators
vim.g.left_sep = ""
vim.g.right_sep = ""

-- Function to get the current mode
local function get_mode()
    local mode_map = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "VISUAL",
        c = "COMMAND"
    }
    return mode_map[vim.api.nvim_get_mode().mode] or "¯\\_(ツ)_/¯"
end

-- Function to append `•` if the buffer has unsaved changes
local function check_mod()
    return vim.bo.modified and vim.fn.expand("%:t") .. "•" or vim.fn.expand("%:t")
end

-- Define highlights
vim.cmd [[
    hi User1 ctermbg=237 guibg=#424242 ctermfg=214 guifg=#ffaf00
    hi User2 ctermbg=232 guibg=#1c1c1c ctermfg=237 guifg=#424242
    hi User3 ctermbg=232 guibg=#1c1c1c ctermfg=222 guifg=#ebdbb2
    hi User4 ctermbg=4   guibg=#458588 ctermfg=232 guifg=#1c1c1c
    hi User5 ctermbg=235 guibg=#282828 ctermfg=4   guifg=#458588
    hi User6 ctermbg=4   guibg=#458588 ctermfg=232 guifg=#1c1c1c
    hi User7 ctermbg=236 guibg=#404040 ctermfg=222 guifg=#ebdbb2
    hi User8 ctermbg=4   guibg=#458588 ctermfg=236 guifg=#404040
    hi User9 ctermbg=232 guibg=#1c1c1c ctermfg=4   guifg=#458588
]]

-- Function to generate the active statusline
local function active_line()
    local statusline = ""
    statusline = statusline .. "%1*" .. " " .. get_mode() .. " "
    statusline = statusline .. "%2*" .. vim.g.left_sep
    statusline = statusline .. "%4*" .. vim.g.left_sep
    statusline = statusline .. " " .. check_mod() .. " "
    statusline = statusline .. "%5*" .. vim.g.left_sep

    statusline = statusline .. "%="  -- Center alignment

    -- Right side of statusline
    statusline = statusline .. " Ln %l (%p%%) "  -- Line number and percentage
    statusline = statusline .. " Col: %-3c "

    return statusline
end

-- Function to generate the inactive statusline
local function inactive_line()
    return " " .. check_mod() .. " "
end

-- Auto-update statusline on window/buffer events
vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = "Statusline",
    pattern = "*",
    callback = function()
        if vim.tbl_contains({ "NERDTree" }, vim.bo.filetype) then return end
        vim.opt_local.statusline = active_line()
    end
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = "Statusline",
    pattern = "*",
    callback = function()
        if vim.tbl_contains({ "NERDTree" }, vim.bo.filetype) then return end
        vim.opt_local.statusline = inactive_line()
    end
})
