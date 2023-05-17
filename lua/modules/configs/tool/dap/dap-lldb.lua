local dap = require("dap")

-- dap.adapters.lldb = {
-- 	type = "executable",
-- 	command = "/usr/bin/lldb-vscode",
-- 	name = "lldb",
-- }
dap.adapters.codelldb = {
	--自动连接codelldb
	type = "server",
	port = "${port}",
	executable = {
		-- CHANGE THIS to your path!
		command = "codelldb",
		args = { "--port", "${port}" },

		--windows需取消注释
		-- detached = false,
	},
}

dap.configurations.cpp = {
	{
		type = "codelldb",
		name = "C/C++调试",
		request = "launch",
		-- 编译输出目录在 cwd/build/,和asynctask中定义的一致
		program = "~/Public/Bin_Files/${fileBasenameNoExtension}.out",
		--       program = function()
		--         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		--       end,
		console = "integratedTerminal",
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}
dap.configurations.c = dap.configurations.cpp
-- dap.configurations.cpp = {
-- 	{
-- 		name = "Launch",
-- 		type = "lldb",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 		stopOnEntry = false,
-- 		args = function()
-- 			local input = vim.fn.input("Input args: ")
-- 			return vim.fn.split(input, " ", true)
-- 		end,

-- 		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
-- 		--
-- 		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
-- 		--
-- 		-- Otherwise you might get the following error:
-- 		--
-- 		--    Error on launch: Failed to attach to the target process
-- 		--
-- 		-- But you should be aware of the implications:
-- 		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
-- 		runInTerminal = false,
-- 	},
-- }

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
