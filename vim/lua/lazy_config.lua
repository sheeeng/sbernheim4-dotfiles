local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
	-- Packer can manage itself

	{ "folke/neodev.nvim" },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true
			},
			explorer = {
				enabled = true,
				layout = {
					layout = {
						width = .8,
						height = .9,
					},
				}
			},
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = {
				enabled = true,
				layout = {
					layout = {
						width = 0.7,
						height = 0.7,
						preview_width = 0.5,
						input_position = "top",
					}
				},
			},
			quickfile = { enabled = true },
			scope = { enabled = true },
			-- scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			styles = {
				notification = {
					-- wo = { wrap = true } -- Wrap notifications
				}
			}
		},
		keys = {
			-- Top Pickers & Explorer
			-- { "ff",         function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
			{ "aa",         function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
			{ "<leader>/",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
			{ "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
			-- { "<leader>n",  function() Snacks.picker.notifications() end,                           desc = "Notification History" },
			{ "<leader>d",  function() Snacks.explorer() end,                                       desc = "File Explorer" },
			-- find
			{ "aa",         function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
			{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "ff",         function() Snacks.picker.files() end,                                   desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
			{ "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
			-- { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
			-- git
			{ "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
			{ "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
			{ "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
			{ "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
			{ "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
			{ "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
			{ "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
			-- Grep
			{ "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
			{ "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
			{ "<leader>sg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
			-- search
			{ '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
			{ '<leader>s/', function() Snacks.picker.search_history() end,                          desc = "Search History" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
			{ "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
			-- { "<leader>sc", function() Snacks.picker.command_history() end,                         desc = "Command History" },
			-- { "<leader>sC", function() Snacks.picker.commands() end,                                desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
			{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
			{ "<leader>hh", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
			{ "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
			{ "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
			{ "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
			{ "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
			{ "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
			{ "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
			{ "<leader>sR", function() Snacks.picker.resume() end,                                  desc = "Resume" },
			{ "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
			{ "<leader>uC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
			-- LSP
			{ "<leader>gd", function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
			{ "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
			-- { "<leader>fr", function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
			{ "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
			{ "<leader>td", function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
			-- Other
			{ "<leader>z",  function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
			{ "<leader>.",  function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
			-- { "<leader>n",  function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
			{ "<leader>q",  function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
			{ "<leader>rf", function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
			{ "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
			{ "<leader>gg", function() Snacks.lazygit() end,                                        desc = "Lazygit" },
			{ "<leader>un", function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
			{ "<c-/>",      function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
			{ "<c-_>",      function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
			{ "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
			{ "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			}
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.option("conceallevel",
						{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
						"<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},

	-- Misc.
	{ "alexghergh/nvim-tmux-navigation" },
	-- { 'hardcoreplayers/dashboard-nvim' },
	{ 'ap/vim-buftabline' },

	-- Feature Enhancers
	{ 'sbernheim4/vim-ripgrep' },
	{ 'mhinz/vim-signify' },
	{ 'ruanyl/vim-gh-line' },
	{ 'rhysd/git-messenger.vim' },

	-- Text Manipulation
	{ 'Raimondi/delimitMate' },
	{ 'tpope/vim-surround' },
	{ 'AndrewRadev/sideways.vim' },
	{ 'FooSoft/vim-argwrap' },

	-- Syntax highlighting
	{ 'nvim-treesitter/nvim-treesitter' },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end
	},

	-- LSP
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{ 'SmiteshP/nvim-navic' },
	{ 'nvim-lua/popup.nvim' },
	{ 'ray-x/lsp_signature.nvim' },

	-- Snippets and Completion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'hrsh7th/vim-vsnip' },
			{ 'hrsh7th/vim-vsnip-integ' },
		}
	},

	{ 'simrat39/symbols-outline.nvim' },

	{
		"pmizio/typescript-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig"
		},
		opts = {},
	},

})
