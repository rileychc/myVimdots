local ui = {}

ui["goolord/alpha-nvim"] = { --开始界面
	lazy = true,
	event = "BufWinEnter",
	config = require("ui.alpha"),
}
ui["akinsho/bufferline.nvim"] = { --buffer管理
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.bufferline"),
}

-- ui["folke/noice.nvim"] = {
-- 	event = "VeryLazy",
-- 	opts = {
-- 		lsp = {
-- 			override = {
-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 				["vim.lsp.util.stylize_markdown"] = true,
-- 				["cmp.entry.get_documentation"] = true,
-- 			},
-- 		},
-- 		presets = {
-- 			bottom_search = true,
-- 			command_palette = true,
-- 			long_message_to_split = true,
-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
-- 		},
-- 	},
-- }

ui["catppuccin/nvim"] = { --主题
	lazy = false,
	name = "catppuccin",
	config = require("ui.catppuccin"),
}
ui["sainnhe/edge"] = { --主题
	lazy = true,
	config = require("ui.edge"),
}
ui["j-hui/fidget.nvim"] = { --实时显示lsp状态
	lazy = true,
	event = "LspAttach",
	config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = { --nvim git 界面管理
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.gitsigns"),
}
ui["lukas-reineke/indent-blankline.nvim"] = { --显示缩进
	lazy = true,
	event = "BufReadPost",
	config = require("ui.indent-blankline"),
}
ui["nvim-lualine/lualine.nvim"] = { --底部状态栏
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.lualine"),
}
ui["zbirenbaum/neodim"] = { --用于调暗未使用的函数、变量、参数等的亮点
	lazy = true,
	event = "LspAttach",
	config = require("ui.neodim"),
}
ui["karb94/neoscroll.nvim"] = { --平滑滑动屏幕
	lazy = true,
	event = "BufReadPost",
	config = require("ui.neoscroll"),
}
ui["shaunsingh/nord.nvim"] = { --主题
	lazy = true,
	config = require("ui.nord"),
}
ui["rcarriga/nvim-notify"] = { --通知窗口
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
ui["folke/paint.nvim"] = { --简单的Neovim插件可以轻松地为您的缓冲区添加额外的亮点。
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
ui["dstein64/nvim-scrollview"] = { --滚动条
	lazy = true,
	event = "BufReadPost",
	config = require("ui.scrollview"),
}
ui["edluffy/specs.nvim"] = { --显示大距离跳跃时光标移动的位置（例如在窗口之间）
	lazy = true,
	event = "CursorMoved",
	config = require("ui.specs"),
}

return ui
