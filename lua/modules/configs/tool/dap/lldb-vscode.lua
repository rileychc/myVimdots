local dap = require("dap")
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/Users/riley/.config/nvim/lua/modules/configs/tool/dap/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		-- request = "debug",
		-- program = function()
		-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- end,
		program = "/Users/riley/Public/Bin_Files/${fileBasenameNoExtension}.out",
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
		-- console = "externalTerminal",
		console = "integratedTerminal",
		MIMode = "lldb",
		miDebuggerPath = "/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/lldb-mi",
		-- externalConsole = true,
		externalConsole = true,
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = false,
			},
		},
	},
	-- {
	-- 	name = "Attach to gdbserver :1234",
	-- 	type = "cppdbg",
	-- 	request = "launch",
	-- 	MIMode = "gdb",
	-- 	miDebuggerServerAddress = "localhost:1234",
	-- 	miDebuggerPath = "/usr/bin/gdb",
	-- 	cwd = "${workspaceFolder}",
	-- 	-- program = function()
	-- 	-- 	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	-- 	-- end,
	-- 	program = "~/Public/Bin_Files/${fileBasenameNoExtension}.out",
	-- },
}
