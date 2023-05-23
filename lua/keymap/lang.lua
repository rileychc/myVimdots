local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
	-- Plugin MarkdownPreview
	["n|<leader>md"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent():with_desc("tool: Preview markdown"),
	-- Plugin clipboard-image
	["n|<leader>mi"] = map_cr("PasteImg"):with_noremap():with_silent():with_desc("tool: Clipboard image"),
}

bind.nvim_load_mapping(plug_map)
