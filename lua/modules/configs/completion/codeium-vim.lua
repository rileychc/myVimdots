return function() --好像跟cmp补全不冲突
	--好中文补全不太好使
	vim.g.codeium_disable_bindings = 1
	vim.keymap.set("i", "<C-e>", function()
		return vim.fn["codeium#Accept"]()
	end, { expr = true })
	vim.keymap.set("i", "<C-n>", function()
		return vim.fn["codeium#CycleCompletions"](1)
	end, { expr = true })
	vim.keymap.set("i", "<C-p>", function()
		return vim.fn["codeium#CycleCompletions"](-1)
	end, { expr = true })
	vim.keymap.set("i", "<C-S-e>", function()
		return vim.fn["codeium#Clear"]()
	end, { expr = true })
end