local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local mapping = {}

function mapping.lsp(buf)
	local map = {
		-- LSP-related keymaps, work only when event = { "InsertEnter", "LspStart" }
		["n|<leader>lf"] = map_cr("LspInfo"):with_buffer(buf):with_desc("lsp: Info"),
		["n|<leader>lr"] = map_cr("LspRestart"):with_buffer(buf):with_nowait():with_desc("lsp: Restart"),
		["n|<leader>ld"] = map_cr("Lspsaga show_line_diagnostics"):with_buffer(buf):with_desc("lsp: Line diagnostic"),
		["n|<leader>li"] = map_cr("Lspsaga incoming_calls"):with_buffer(buf):with_desc("lsp: Show incoming calls"),
		["n|<leader>lo"] = map_cr("Lspsaga outgoing_calls"):with_buffer(buf):with_desc("lsp: Show outgoing calls"),
		["n|go"] = map_cr("Lspsaga outline"):with_buffer(buf):with_desc("lsp: Toggle outline"),
		["n|[g"] = map_cr("Lspsaga diagnostic_jump_prev"):with_buffer(buf):with_desc("lsp: Prev diagnostic"),
		["n|]g"] = map_cr("Lspsaga diagnostic_jump_next"):with_buffer(buf):with_desc("lsp: Next diagnostic"),
		["n|gK"] = map_callback(function()
			vim.lsp.buf.signature_help()
		end):with_desc("lsp: Signature help"),
		["n|<F2>"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename in file range"),
		["n|<F14>"] = map_cr("Lspsaga rename ++project"):with_buffer(buf):with_desc("lsp: Rename in project range"),
		["n|gk"] = map_cr("Lspsaga hover_doc"):with_buffer(buf):with_desc("lsp: Show doc"),
		["nv|ga"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action for cursor"),
		["n|gd"] = map_cr("Lspsaga peek_definition"):with_buffer(buf):with_desc("lsp: Preview definition"),
		["n|gD"] = map_cr("Lspsaga goto_definition"):with_buffer(buf):with_desc("lsp: Goto definition"),
		["n|gr"] = map_cr("Lspsaga lsp_finder"):with_buffer(buf):with_desc("lsp: Show reference"),
	}
	bind.nvim_load_mapping(map)
end

return mapping
