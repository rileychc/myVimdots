return function()
	local icons = {
		ui = require("modules.utils.icons").get("ui"),
		misc = require("modules.utils.icons").get("misc"),
	}
	local keymaps = {
		mode = { "n", "v" },
		["<leader>g"] = { name = "+Git" },
		["<leader>e"] = { name = "+NvimTree" },
		["<leader>L"] = { name = "+Lsp" },
		["<leader>d"] = { name = "+Debug" },
		["<leader>b"] = { name = "+Buffer" },
		["<leader>f"] = { name = "+TelescopeFind" },
		["<leader>t"] = { name = "+TroubleToggle" },
		["<leader>m"] = { name = "+Markdown" },
		["<leader>p"] = { name = "+Package" },
		["<leader>q"] = { name = "+Session" },
	}
	require("which-key").setup({

		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = true,
				g = true,
			},
		},

		icons = {
			breadcrumb = icons.ui.Separator,
			separator = icons.misc.Vbar,
			group = icons.misc.Add,
		},

		window = {
			border = "none",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			padding = { 1, 1, 1, 1 },
			winblend = 0,
		},
	})
	require("which-key").register(keymaps)
end
