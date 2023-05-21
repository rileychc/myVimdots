local dap = require("dap")
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
dap.configurations.rust = dap.configurations.cpp
