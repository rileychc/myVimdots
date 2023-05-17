local completion = {}

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("completion.lsp"),
	dependencies = {
		{ "ray-x/lsp_signature.nvim" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"nvimdev/lspsaga.nvim",
			config = require("completion.lspsaga"),
		},
	},
}
completion["jose-elias-alvarez/null-ls.nvim"] = { --代码格式化插件
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("completion.null-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
}

completion["hrsh7th/nvim-cmp"] = { --代码补全插件
	lazy = true,
	event = "InsertEnter",
	config = require("completion.cmp"),
	dependencies = {
		{
			"L3MON4D3/LuaSnip", --代码片段插件
			dependencies = { "rafamadriz/friendly-snippets" }, --代码片段来源
			config = require("completion.luasnip"),
		},
		{ "lukas-reineke/cmp-under-comparator" }, --下划线项的更好完成排序
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "andersevenrud/cmp-tmux" },
		{ "hrsh7th/cmp-path" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-buffer" },
		{ "kdheepak/cmp-latex-symbols" },
		{ "ray-x/cmp-treesitter" },
		--忘了
		-- { "tzachar/cmp-tabnine", build = "./install.sh", config = require("completion.tabnine") },
		-- {
		-- 	"jcdickinson/codeium.nvim",
		-- 	dependencies = {
		-- 		"nvim-lua/plenary.nvim",
		-- 		"MunifTanjim/nui.nvim",
		-- 	},
		-- 	config = require("completion.codeium"),
		-- },
	},
}
-- completion["zbirenbaum/copilot.lua"] = {
--     lazy = true,
--     endabled = true,
--     cmd = "Copilot",
--     event = "InsertEnter",
--     config = require("completion.copilot"),
--     dependencies = {
--         {
--             "zbirenbaum/copilot-cmp",
--             config = require("completion.copilot-cmp"),
--         },
--     },
-- }

return completion
