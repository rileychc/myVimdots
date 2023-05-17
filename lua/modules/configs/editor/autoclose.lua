return function()
	--括号配对
	require("autoclose").setup({
		keys = {
			["("] = { escape = false, close = true, pair = "()" },
			["["] = { escape = false, close = true, pair = "[]" },
			["{"] = { escape = false, close = true, pair = "{}" },

			[">"] = { escape = true, close = false, pair = "<>" },
			[")"] = { escape = true, close = false, pair = "()" },
			["]"] = { escape = true, close = false, pair = "[]" },
			["}"] = { escape = true, close = false, pair = "{}" },

			['"'] = { escape = true, close = true, pair = '""' },
			["'"] = { escape = true, close = true, pair = "''" },
			["`"] = { escape = true, close = true, pair = "``" },
		},
		options = {
			disabled_filetypes = { "big_file_disabled_ft" },
			disable_when_touch = false,
		},
	})
end
