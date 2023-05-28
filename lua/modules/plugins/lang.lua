local lang = {}

lang["fatih/vim-go"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	config = require("lang.vim-go"),
}
lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["iamcco/markdown-preview.nvim"] = { --markdown预览插件
	lazy = true,
	ft = "markdown",
	build = "source /usr/share/nvm/init-nvm.sh; nvm use v18; cd app && npm install",
	config = require("lang.markdown-preview"),
}

lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
return lang
