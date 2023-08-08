vim.opt.number = true

vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'

vim.cmd([[packadd packer.nvim]])

local packer = require("packer")

packer.startup(function(use)
        use("wbthomason/packer.nvim")

        use {'christoomey/vim-tmux-navigator', lazy = false}
        use 'nvim-lua/plenary.nvim'
	-- use 'jose-elias-alvarez/null-ls.nvim'
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

	use {
	    "williamboman/mason.nvim",
	    "williamboman/mason-lspconfig.nvim",
    	    "neovim/nvim-lspconfig",
	    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
	}

      -- colorscheme

      -- nightfox
        use("EdenEast/nightfox.nvim")
        -- vim.cmd("colorscheme nordfox")

        use("folke/tokyonight.nvim")
        vim.cmd("colorscheme tokyonight-storm")

        -- nvim-web-devicons
        use('nvim-tree/nvim-web-devicons')

        use {
          'nvim-lualine/lualine.nvim',
          requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }

        require("lualine").setup({
          options = {
            icons_enabled = true,
            theme = "solarized_dark",
          },
        })

        use("nvim-treesitter/nvim-treesitter")

        require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "lua", "rust" },
          highlight = {
            enable = false,
          },
        })

        use("junegunn/fzf")
        use("junegunn/fzf.vim")

        use("nvim-telescope/telescope.nvim")

        use {
            "nvim-telescope/telescope-file-browser.nvim",
            requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
        }

        -- hop installation
        use{
          'phaazon/hop.nvim',
          branch = 'v2',
        }
end)

vim.opt.list = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.swapfile = false
vim.opt.wrap = true
-- Map global leader from \ to Space
vim.g.mapleader = " "
-- Open recently used files
-- vim.api.nvim_set_keymap("n", "<leader>fr", ":History<CR>", { noremap = true })
-- Open files in same directory as current file
-- vim.api.nvim_set_keymap("n", "<leader>ff", ":e %:h/<C-d>", { noremap = true })

-- personal keybindings

vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })

-- telescope configuration

local fb_actions = require "telescope._extensions.file_browser.actions"

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    file_browser = {
      -- path
      -- cwd
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = false,
      -- respect_gitignore
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true },
      hijack_netrw = false,
      use_fd = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,
          ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<C-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
        },
        ["n"] = {
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["g"] = fb_actions.goto_parent_dir,
          ["e"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["h"] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
        },
      },
    },
  },
}

-- telescope search keybinding

local builtin = require('telescope.builtin')

require("telescope").load_extension "file_browser"

vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })

-- telescope file browser keybindings

vim.api.nvim_set_keymap("n", "<leader>fc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })

-- tab navigation

vim.api.nvim_set_keymap("n", "<leader>1", "1gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>2", "2gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>3", "3gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>4", "4gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>5", "5gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>6", "6gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>7", "7gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>8", "8gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>9", "9gt<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>0", ":tablast<CR>", { noremap = true })

-- windows navigation

vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j<CR>", { noremap = true })



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Theme, colors and gui
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

local servers = {
	pyright = {},
	-- eslint = {
	-- 	codeAction = {
	-- 		disableRuleComment = {
	-- 			enable = true,
	-- 			location = "separateLine",
	-- 		},
	-- 		showDocumentation = {
	-- 			enable = true,
	-- 		},
	-- 	},
	-- 	codeActionOnSave = {
	-- 		enable = false,
	-- 		mode = "all",
	-- 	},
	-- 	format = false,
	-- 	nodePath = "",
	-- 	onIgnoredFiles = "off",
	-- 	packageManager = "npm",
	-- 	quiet = false,
	-- 	rulesCustomizations = {},
	-- 	run = "onType",
	-- 	useESLintClass = false,
	-- 	validate = "on",
	-- 	workingDirectory = {
	-- 		mode = "location",
	-- 	},
	-- },
	bashls = {},
	cssls = {},
	html = {},
	jsonls = {},
	lemminx = {},
	-- gopls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	tsserver = {}
}

require("mason").setup({
    ui = {
	icons = {
	    package_installed = "✓",
	    package_pending = "➜",
	    package_uninstalled = "✗"
	}
    }
})

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- nvim-cmp setup
-- local cmp = require 'cmp'
-- cmp.setup {
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body)
--         end,
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<CR>'] = cmp.mapping.confirm {
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true,
--         },
--         ['<Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--         ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--     }),
--     sources = {
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--     },
-- }

-- NULL-LS.NVIM
-- LSP formatting filter
-- local lsp_formatting = function(bufnr)
-- 	vim.lsp.buf.format({
-- 		filter = function(client)
-- 			-- Ignore formatting from these LSPs
-- 			local lsp_formatting_denylist = {
-- 				eslint = true,
-- 				lemminx = true,
-- 				lua_ls = true,
-- 			}
-- 			if lsp_formatting_denylist[client.name] then
-- 				return false
-- 			end
-- 			return true
-- 		end,
-- 		bufnr = bufnr,
-- 	})
-- end
-- 
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local null_ls = require('null-ls')
-- null_ls.setup({
-- 	-- you can reuse a shared lspconfig on_attach callback here
-- 	on_attach = function(client, bufnr)
-- 		if client.supports_method("textDocument/formatting") then
-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup,
-- 				buffer = bufnr,
-- 				callback = function()
-- 					lsp_formatting(bufnr)
-- 				end,
-- 			})
-- 		end
-- 	end,
-- 	sources = {
-- 		null_ls.builtins.formatting.prettier.with({
-- 			extra_filetypes = { "xml" },
-- 		}),
-- 		null_ls.builtins.formatting.black,
-- 		null_ls.builtins.formatting.djlint,
-- 		null_ls.builtins.formatting.isort,
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.diagnostics.djlint,
-- 		null_ls.builtins.diagnostics.flake8,
-- 		null_ls.builtins.diagnostics.pylint,
-- 	},
-- })
