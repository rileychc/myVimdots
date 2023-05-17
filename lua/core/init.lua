local global = require("core.global")

-- Create cache dir and data dirs
local createdir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
		global.cache_dir .. "undo",
	}
	-- Only check whether cache_dir exists, this would be enough.
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

local disable_distribution_plugins = function()
	-- disable menu loading 已经安装了默认菜单和语法菜单
	vim.g.did_install_default_menus = 1
	vim.g.did_install_syntax_menu = 1

	-- Uncomment this if you define your own filetypes in `after/ftplugin` 已经加载了自定义的文件类型定义，通常用于 after/ftplugin 目录中
	-- vim.g.did_load_filetypes = 1

	-- Do not load native syntax completion  不加载原生的语法自动补全功能。
	vim.g.loaded_syntax_completion = 1

	-- Do not load spell files   不加载拼写检查插件
	vim.g.loaded_spellfile_plugin = 1

	-- Whether to load netrw by default   不加载 netrw 文件管理器插件
	-- vim.g.loaded_netrw = 1
	-- vim.g.loaded_netrwFileHandlers = 1
	-- vim.g.loaded_netrwPlugin = 1
	-- vim.g.loaded_netrwSettings = 1
	-- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456 用于定义 netrw 文件管理器的列表样式。
	vim.g.netrw_liststyle = 3

	-- Do not load tohtml.vim  不加载将 Vim 编辑的文件转换为 HTML 格式的插件。
	vim.g.loaded_2html_plugin = 1

	-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
	-- related to checking files inside compressed files) 不加载与压缩文件相关的插件
	vim.g.loaded_gzip = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.loaded_zipPlugin = 1

	-- Do not use builtin matchit.vim and matchparen.vim since the use of vim-matchup  不使用内置的 matchit.vim 和 matchparen.vim 插件，因为使用了 vim-matchup 插件
	vim.g.loaded_matchit = 1
	vim.g.loaded_matchparen = 1

	-- Disable sql omni completion.  禁用 SQL 自动补全功能
	vim.g.loaded_sql_completion = 1

	-- Disable EditorConfig support   启用 EditorConfig 支持
	vim.g.editorconfig = 1

	-- Disable remote plugins
	-- NOTE: Disabling rplugin.vim will show error for `wilder.nvim` in :checkhealth,
	-- NOTE:  but since it's config doesn't require python rtp, it's fine to ignore. 不加载远程插件
	-- vim.g.loaded_remote_plugins = 1
end

local leader_map = function()
	vim.g.mapleader = " "
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function() --gui配置
	vim.api.nvim_set_option_value("guifont", "JetBrainsMono Nerd Font:h15", {})
	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_cursor_trail_length = 0.05
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_speed = 20.0
	vim.g.neovide_cursor_vfx_particle_density = 5.0
end

local clipboard_config = function() --剪贴板配置
	if global.is_mac then
		vim.g.clipboard = {
			name = "macOS-clipboard",
			copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
			paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
			cache_enabled = 0,
		}
	elseif global.is_wsl then
		vim.g.clipboard = {
			name = "win32yank-wsl",
			copy = {
				["+"] = "win32yank.exe -i --crlf",
				["*"] = "win32yank.exe -i --crlf",
			},
			paste = {
				["+"] = "win32yank.exe -o --lf",
				["*"] = "win32yank.exe -o --lf",
			},
			cache_enabled = 0,
		}
	end
end

local shell_config = function()
	if global.is_windows then
		if not (vim.fn.executable("pwsh") or vim.fn.executable("powershell")) then
			vim.notify(
				[[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
				vim.log.levels.WARN,
				{ title = "[core] Runtime error" }
			)
			return
		end

		local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
		local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8"
		vim.api.nvim_set_option_value("shell", vim.fn.executable("pwsh") and "pwsh" or "powershell", {})
		vim.api.nvim_set_option_value("shellcmdflag", string.format("%s %s;", basecmd, ctrlcmd), {})
		vim.api.nvim_set_option_value("shellredir", "-RedirectStandardOutput %s -NoNewWindow -Wait", {})
		vim.api.nvim_set_option_value("shellpipe", "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode", {})
		vim.api.nvim_set_option_value("shellquote", nil, {})
		vim.api.nvim_set_option_value("shellxquote", nil, {})
	end
end

local load_core = function()
	createdir()
	disable_distribution_plugins()
	leader_map()

	neovide_config()
	clipboard_config()
	shell_config()

	require("core.options")
	require("core.mapping")
	require("keymap")
	require("core.event")
	require("core.pack")

	local colorscheme = require("core.settings").colorscheme
	local background = require("core.settings").background
	vim.api.nvim_command("set background=" .. background)
	vim.api.nvim_command("colorscheme " .. colorscheme)
end

load_core()
