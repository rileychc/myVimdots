local editor = {}

editor["folke/todo-comments.nvim"] = { --TODO标记插件
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	config = true,
}
editor["rainbowhxch/accelerated-jk.nvim"] = { --加速jk退出，优化体验
	lazy = true,
	event = "VeryLazy",
	config = require("editor.accelerated-jk"),
}
editor["max397574/better-escape.nvim"] = { --同上
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.better-escape"),
}
editor["rmagatti/auto-session"] = { --会话管理
	lazy = true,
	cmd = { "SessionSave", "SessionRestore", "SessionDelete" },
	config = require("editor.auto-session"),
}
editor["m4xshen/autoclose.nvim"] = { --括号配对
	lazy = true,
	event = "InsertEnter",
	config = require("editor.autoclose"),
}

editor["LunarVim/bigfile.nvim"] = { --加载大文件
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}
editor["ojroques/nvim-bufdel"] = { --buffer操作
	lazy = true,
	event = "BufReadPost",
}

editor["numToStr/Comment.nvim"] = { --注释插件
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = { --查看git更改管理
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
editor["junegunn/vim-easy-align"] = { --更好的对其文本，但是不太懂怎么用
	lazy = true,
	cmd = "EasyAlign",
}
editor["ggandor/leap.nvim"] = { --字符跳转插件
	lazy = true,
	event = "BufReadPost",
	config = require("editor.leap-nvim"),
}
editor["ggandor/flit.nvim"] = { --同上
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	dependencies = {
		{ "ggandor/leap.nvim" },
	},
	keys = function()
		local ret = {}
		for _, key in ipairs({ "f", "F", "T", "t" }) do
			ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
		end
		return ret
	end,
	opts = { labeled_modes = "nx" },
}
editor["RRethy/vim-illuminate"] = { --高亮当前鼠标所在位置的内容
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}
editor["romainl/vim-cool"] = { --搜索完成后，自动退出搜索高亮
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
}
editor["lambdalisue/suda.vim"] = { --管理员用户强制保存
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	config = require("editor.suda"),
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = { --文本高亮
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command("TSUpdate")
		end
	end,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "nvim-treesitter/nvim-treesitter-context" },
		{ "mrjones2014/nvim-ts-rainbow" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "mfussenegger/nvim-treehopper" },
		{ "andymass/vim-matchup" }, --更好的匹配%(即括号配对)
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"NvChad/nvim-colorizer.lua", --在文本上显示相应的颜色，例：blue
			config = require("editor.colorizer"),
		},
		{
			"abecodes/tabout.nvim",
			config = require("editor.tabout"),
		},
	},
}

return editor
