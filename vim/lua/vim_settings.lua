-- #######################################################################
-- ######## Folding
-- ########################################################################

vim.o.foldmethod = "expr"
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.o.foldcolumn = "0"
vim.o.foldlevelstart = 99

vim.opt.fillchars:append({ vert = "█" })
vim.opt.viewoptions:remove("options")

function _G.custom_fold_text()
    local line = vim.fn.getline(vim.v.foldstart)
    local nextLine = vim.fn.getline(vim.v.foldstart + 1)

    -- parse comment
    if (string.find(line, "/*")) then
        if (containsString(nextLine, "description") ~= nil) then
            return string.sub(nextLine, containsString(nextLine, "description") + 12, nextLine:len() - 1)
        elseif (containsString(nextLine, "*") ~= nil) then
            return string.sub(nextLine, containsString(nextLine, "*") + 2, nextLine:len() - 1)
        else
            return nextLine
        end

        return nextLine
    end

    -- Return the default treesitter folded text - this is for code
    return vim.treesitter.foldtext()
end

vim.opt.foldtext = 'v:lua.custom_fold_text()'

function _G.containsString(text, match)
    local lowerText = string.lower(text)
    local lowerMatch = string.lower(match)
    local descriptionIndex = lowerText:find(lowerMatch, 1, true);
    return descriptionIndex
end

-- ########################################################################
-- General Settings
-- ########################################################################

local opt = vim.opt

opt.cursorline = true                        -- Highlight the current cursor line
opt.number = true                            -- Display line numbers
opt.relativenumber = true                    -- Use relative line numbers
opt.encoding = "utf8"                        -- Use UTF-8 encoding
opt.backspace = { "indent", "eol", "start" } -- Normal backspace behavior
opt.splitbelow = true                        -- Splits open below
opt.splitright = true                        -- Splits open to the right
opt.scrolloff = 4                            -- Start scrolling 4 lines before edge
opt.autowrite = true                         -- Auto write on :next/:prev
opt.signcolumn = "yes"                       -- Always show sign column
opt.smartindent = true                       -- Auto-indent appropriately
opt.timeoutlen = 200                         -- Timeout for mapped sequences
opt.mouse = ""                               -- Disable mouse

-- ########################################################################
-- Line Wrapping
-- ########################################################################
opt.wrap = false
opt.breakindent = true
opt.linebreak = true
opt.breakindentopt = "shift:3,sbr"
opt.textwidth = 80
opt.colorcolumn = ""

-- ########################################################################
-- Backup Settings
-- ########################################################################
opt.backup = false
opt.swapfile = false
opt.undofile = false

-- ########################################################################
-- Tabs and Spaces
-- ########################################################################
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false -- Use tabs instead of spaces

-- ########################################################################
-- Search Settings
-- ########################################################################
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "split"

if vim.fn.executable('rg') == 1 then
    opt.grepprg = "rg --vimgrep --no-heading"
    opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- ########################################################################
-- Undo Info
-- ########################################################################
opt.undodir = vim.fn.expand("~/.vim/undo-dir")
opt.undofile = true

-- ########################################################################
-- List Characters
-- ########################################################################
opt.list = true
opt.list = true
opt.listchars = { tab = "• " }
opt.fillchars:append("vert:█")

-- ########################################################################
-- Status Line
-- ########################################################################
opt.laststatus = 3
opt.showmode = false
opt.showtabline = 2


-- ########################################################################
-- Folding
-- ########################################################################
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
opt.foldcolumn = "0"
opt.foldlevelstart = 99

-- ########################################################################
-- Completion Settings
-- ########################################################################
opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
opt.shortmess:append("c")
opt.shortmess:remove("F")

-- ########################################################################
-- Auto Commands
-- ########################################################################
local blacklist = { "NvimTree", "Outline", "qf", "dashboard" }

local function resize_splits()
    local ft = vim.bo.filetype
    if ft == "NvimTree" then
        vim.cmd("vertical resize 30")
        opt.relativenumber = false
        vim.wo.signcolumn = "yes"
    elseif ft == "Outline" or ft == "dashboard" then
        opt.relativenumber = false
    elseif ft == "qf" then
        vim.cmd("resize 10")
    else
        opt.winwidth = 100
        vim.cmd("wincmd =")
    end
end

vim.api.nvim_create_augroup("ReduceNoise", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
    group = "ReduceNoise",
    callback = resize_splits
})

vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave" }, {
    group = "ReduceNoise",
    callback = function()
        local ft = vim.bo.filetype
        if not vim.tbl_contains(blacklist, ft) then
            opt.signcolumn = vim.fn.win_getid() == vim.fn.win_getid() and "auto" or "no"
            opt.cursorline = vim.fn.win_getid() == vim.fn.win_getid()
            opt.relativenumber = vim.fn.win_getid() == vim.fn.win_getid()
        end
    end
})

-- Custom Highlight Groups
vim.cmd [[
    hi Visual guifg=#575757 guibg=#d1d1d1
    hi QuickFixLine guibg=#282828 guifg=#e8d8c5

    hi LspDiagnosticsDefaultError guifg=#e5898b
    hi LspDiagnosticsDefaultWarning guifg=#edbb7b
    hi LspDiagnosticsDefaultHint guifg=#b1bbbf

    hi SignifySignAdd guifg=#b8ba25
    hi SignifySignDelete guifg=#fa4933
    hi SignifySignChange guifg=#458488

    " Set color for vertical bar for the color column
    hi ColorColumn guibg=#3a3a3a

    " Set background for vertical vim split
    hi vertsplit guifg=white guibg=white
    hi VertSplit ctermbg=NONE guibg=NONE

    " Highlight color for the cursor line
    hi CursorLine guibg=#3d3d3d

    hi SignColumn guibg=#282828
]]
