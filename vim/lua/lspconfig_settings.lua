local lspconfig = require('lspconfig')
local cmp = require('cmp_nvim_lsp')
local navic = require('nvim-navic')

require('neodev').setup({})
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		'eslint',
		'intelephense',
		'jsonls',
		'rust_analyzer',
		'cssls',
		'gopls',
		'vimls',
		'bashls',
		'graphql',
		'vimls',
		'yamlls',
		'pyright',
		'graphql',
		'lua_ls',

	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)

		-- Display the location in the winbar
		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
	end
end

local completion_capabilities = cmp.default_capabilities(capabilities)

lspconfig.eslint.setup {}
lspconfig.intelephense.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.jsonls.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.rust_analyzer.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.cssls.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.gopls.setup { capabilities = capabilities, on_attach = on_attach }
require("typescript-tools").setup {
	capabilities = completion_capabilities,
	on_attach = on_attach,
	settings = {
		tsserver_file_preferences = {
			includeInlayParameterNameHints = "all",
			includeCompletionsForModuleExports = true,
			quotePreference = "auto",
		},
		tsserver_format_options = {
			allowIncompleteCompletions = false,
			allowRenameOfImportPath = false,
		}
	},
}
lspconfig.vimls.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.bashls.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.graphql.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.vimls.setup { capabilities = completion_capabilities, on_attach = on_attach }
lspconfig.yamlls.setup {
	capabilities = completion_capabilities,
	schemaStore = { url = "https://www.schemastore.org/api/json/catalog.json" },
	on_attach = on_attach
}
lspconfig.pyright.setup {}
lspconfig.graphql.setup({
	filetypes = { 'graphql', 'gql' },
	on_attach = on_attach,
	root_dir = lspconfig.util.root_pattern(
		".graphqlconfig",
		".graphql.json",
		".graphqlrc",
		"package.json",
		"graphql.config.ts"
	),
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = capabilities,
})

-- Lua
local sumneko_root_path = vim.fn.expand('$HOME/.local/share/nvim/lsp_servers/sumneko_lua/extension/server')
local sumneko_binary = sumneko_root_path .. "/bin" .. "/lua-language-server"

lspconfig.lua_ls.setup {
	on_attach = on_attach,
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace"
			},
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = { globals = { 'vim' }, },
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}


-- LSP Config Mappings
-- vim.api.nvim_set_keymap('n', '<Leader>gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>td', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ac', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>gg', ':lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gn', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gp', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	'n',
	'<Leader>c',
	':lua vim.lsp.buf.format({async = true})<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>ee',
	':lua vim.diagnostic.setqflist()<CR>',
	{ noremap = true, silent = true }
);
