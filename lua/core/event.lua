-- Now use `<A-k>` or `<A-1>` to back to the `dotstutor`.
local autocmd = {}
--NOTE:
function autocmd.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command("augroup " .. group_name)
		vim.api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command("augroup END")
	end
end
--NOTE:
local mapping = require("keymap.completion")
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		mapping.lsp(event.buf)
	end,
})

-- auto close NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.api.nvim_command([[confirm quit]])
		end
	end,
})

-- auto close some filetype with <q>
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"nofile",
		"lspinfo",
		"terminal",
		"prompt",
		"toggleterm",
		"copilot",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
	end,
})

-- 修复了望远镜打开文件的折叠问题
vim.api.nvim_create_autocmd("BufRead", {
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx",
		})
	end,
})

--在保证窗口布局的情况下删除缓冲区
vim.api.nvim_create_user_command("BufferDelete", function()
	---@diagnostic disable-next-line: missing-parameter
	local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
	local modified = vim.api.nvim_buf_get_option(0, "modified")
	if file_exists == 0 and modified then
		local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
		if user_choice == "y" or string.len(user_choice) == 0 then
			vim.cmd("bd!")
		end
		return
	end
	local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
	vim.cmd(force and "bd!" or string.format("bp | bd! %s", vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })
--创建缺失的目录
vim.api.nvim_create_user_command("MakeDirectory", function()
	---@diagnostic disable-next-line: missing-parameter
	local path = vim.fn.expand("%")
	local dir = vim.fn.fnamemodify(path, ":p:h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	else
		---@diagnostic disable-next-line: param-type-mismatch
		vim.notify("Directory already exists", "WARN", { title = "Nvim" })
	end
end, { desc = "Create directory if it doesn't exist" })

function autocmd.load_autocmds()
	vim.cmd([[
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.go exec ":call SetTitle()"
"""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."),   "\# File Name:    ".expand("%"))
        call append(line(".")+1, "\# Author:       rileychc")
        call append(line(".")+2, "\# mail:         rileychc8@gmail.com")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
    else
        call setline(1, "/* ************************************************************************")
        call append(line("."),   "> File Name:     ".expand("%"))
        call append(line(".")+1, "> Author:        rileychc")
        call append(line(".")+2, "> mail:          rileychc8@gmail.com")
        call append(line(".")+3, "> Created Time:  ".strftime("%c"))
        call append(line(".")+4, "> Description:   ")
        call append(line(".")+5, " ************************************************************************/")
        call append(line(".")+6, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc
]])

	vim.cmd([[
autocmd BufNewFile *.h,*.hpp exec ":call AddHHeader()"
func AddHHeader()
    let macro = "_".toupper(substitute(expand("%"), "[/.]", "_", "g"))."_"
    "normal o
    call setline(9, "#ifndef ".macro)
    call setline(10, "#define ".macro)
    call setline(11, "")
    call setline(12, "#endif  // ".macro)
endfunc
]])

	--一键编译c/cpp
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "c",
		callback = function()
			-- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<F19>",
				"<ESC><cmd>!g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/%:t:r.out  % -g -I ./include/ -I .. -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG<CR><CR>",
				{ silent = true, noremap = true }
			)
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "cpp",
		callback = function()
			-- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<F19>",
				"<ESC><cmd>!g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/%:t:r.out  % -g -I ./include/ -I .. -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG<CR><CR>",
				{ silent = true, noremap = true }
			)
		end,
	}) --./src/*.cpp

	--一键运行代码文件
	--C
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "c",
		callback = function()
			-- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<F7>",
				"<ESC>:w<CR>:split<CR>:te gcc  -std=c17 -Wshadow -Wall -o ~/Public/Bin_Files/%:t:r.out % -g -I ./include/ -I ..  -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ~/Public/Bin_Files/%:t:r.out<CR>i", --%:t:r
				{ silent = true, noremap = true }
			)
		end,
	})
	--C++
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "cpp",
		callback = function()
			-- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<F7>",
				"<ESC>:w<CR>:split<CR>:te g++ -std=c++17 -Wshadow -Wall -o ~/Public/Bin_Files/%:t:r.out %  -g -I ./include/  -I /Users/riley/Public/Leetcode/cpp/  -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ~/Public/Bin_Files/%:t:r.out<CR>i\n", --
				{ silent = true, noremap = true }
			)
		end,
	})
	--Python
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function()
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<F7>",
				":w<CR>:split<CR>:te  time python3 % <CR>i",
				{ silent = true, noremap = true }
			)
		end,
	})
	--Java
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function()
			vim.api.nvim_buf_set_keymap(
				0,
				"n",
				"<F7>",
				":w<CR>:split<CR>:te  time java % <CR>i",
				{ silent = true, noremap = true }
			)
		end,
	})

	local definitions = {
		lazy = {},
		bufs = {
			-- Reload vim config automatically
			{
				"BufWritePost",
				[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]],
			},
			-- 如果设置本地自动读取，则自动重新加载Vim脚本
			{
				"BufWritePost,FileWritePost",
				"*.vim",
				[[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
			},
			{ "BufWritePre", "/tmp/*", "setlocal noundofile" },
			{ "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
			{ "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
			{ "BufWritePre", "*.tmp", "setlocal noundofile" },
			{ "BufWritePre", "*.bak", "setlocal noundofile" },
			-- auto place to last edit
			{
				"BufReadPost",
				"*",
				[[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
			},
			-- Auto toggle fcitx5输入法
			-- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
			-- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
			-- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
			-- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
		},
		wins = {
			-- Highlight current line only on focused window
			{
				"WinEnter,BufEnter,InsertLeave",
				"*",
				[[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
			},
			{
				"WinLeave,BufLeave,InsertEnter",
				"*",
				[[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
			},
			-- Force write shada(存储持久session信息) on leaving nvim
			{
				"VimLeave",
				"*",
				[[if has('nvim') | wshada! | else | wviminfo! | endif]],
			},
			-- Check if file changed when its window is focus, more eager than 'autoread'
			{ "FocusGained", "* checktime" },
			-- Equalize window dimensions when resizing vim window /平衡调整vim窗口时窗口的大小
			{ "VimResized", "*", [[tabdo wincmd =]] },
		},
		--一些自动命令
		ft = {
			{ "FileType", "alpha", "set showtabline=0" },
			{ "FileType", "markdown", "set wrap" },
			{ "FileType", "make", "set noexpandtab shiftwidth=8 softtabstop=0" },
			{ "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
			{
				"FileType",
				"*",
				[[setlocal formatoptions-=cro]],
			},
			{
				"FileType",
				"c,cpp",
				"nnoremap <leader>H :ClangdSwitchSourceHeaderVSplit<CR>",
			},
		},
		yank = {
			{
				"TextYankPost",
				"*",
				[[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]],
			},
		},
	}

	autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
