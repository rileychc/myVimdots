local tool = {}

tool["JuanZoran/Trans.nvim"] = { --翻译插件
	event = "VeryLazy",
	build = function()
		require("Trans").install()
	end,
	keys = {
		{ "<leader>tl", "<cmd>Translate<CR>", mode = { "n", "v" }, desc = "Translate" },
		{ "<leader>ti", "<cmd>TranslateInput<CR>", mode = { "n", "v" }, desc = "InputTranslate" },
		{ "<leader>tp", "<cmd>TransPlay<CR>", mode = { "n", "v" }, desc = "TransPlay" },
	},
	dependencies = { "kkharji/sqlite.lua" },
	config = require("tool.Trans"),
}
tool["mg979/vim-visual-multi"] = { --多光标插件
	event = "VeryLazy",
	config = require("tool.vim-visual-multi"),
}
tool["madskjeldgaard/cppman.nvim"] = { --cpp文档插件
	-- event = "VeryLazy",
	dependencies = {
		{
			"MunifTanjim/nui.nvim",
			event = "VeryLazy",
		},
	},
	config = require("tool.cppman-nvim"),
}
tool["tpope/vim-fugitive"] = { --git插件
	lazy = true,
	cmd = { "Git", "G" },
}
-- only for fcitx5 user who uses non-English language during coding
-- tool["pysan3/fcitx5.nvim"] = {--输入法
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	cond = vim.fn.executable("fcitx5-remote") == 1,
-- 	config = require("tool.fcitx5"),
-- }
tool["nvim-tree/nvim-tree.lua"] = { --文件浏览
	lazy = true,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
	config = require("tool.nvim-tree"),
}
tool["ibhagwan/smartyank.nvim"] = { --智能复制
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}
tool["michaelb/sniprun"] = { --局部代码执行
	lazy = true,
	-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
	-- if you encountered error about no executable sniprun found.
	build = "bash ./install.sh",
	cmd = { "SnipRun" },
	config = require("tool.sniprun"),
}
tool["akinsho/toggleterm.nvim"] = {
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},
	config = require("tool.toggleterm"),
}
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = require("tool.trouble"),
}
tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}
tool["gelguy/wilder.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = "BufReadPost",
			config = require("tool.project"),
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-frecency.nvim", dependencies = {
			{ "kkharji/sqlite.lua" },
		} },
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	config = require("tool.dap"),
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = require("tool.dap.dapui"),
		},

		{
			"theHamsta/nvim-dap-virtual-text", --虚拟文本(可有可无)
			opts = {
				enabled = true,
				enable_commands = true, --创建命令DapVirtualTextEnable，DapVirtualTextDisable，DapVirtualTextToggle，（当调试适配器没有通知其终止时，DapVirtualTextForceRefresh用于刷新）
				highlight_changed_variables = true, --使用NvimDapVirtualTextChanged突出显示更改的值，否则总是NvimDapVirtualText
				highlight_new_as_changed = true, --以与更改变量相同的方式突出显示新变量（如果highlight_changed_variables）
				show_stop_reason = true, --当因异常而停止时显示停止原因
				commented = true, --用注释字符串前缀虚拟文本
				only_first_definition = true, --仅在第一个定义时显示虚拟文本（如果有多个）
				all_references = false, --在变量的所有引用上显示虚拟文本（不仅仅是定义）
				filter_references_pattern = "<module",
				virt_text_pos = "eol", --虚拟文本的位置，请参阅`:h nvim_buf_set_extmark()`
				all_frames = false, --显示所有堆栈帧的虚拟文本，而不仅仅是当前。仅适用于我的机器上的调试。
				virt_lines = false, --显示虚拟行而不是虚拟文本（将闪烁！）
				virt_text_win_col = nil,
			},
		},
		{
			"Weissle/persistent-breakpoints.nvim", --保存断点(可有可无)
			event = "BufReadPost",
			opts = { load_breakpoints_event = "BufReadPost" },
		},
	},
}

return tool
