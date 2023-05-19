local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local core_map = {
	["n|<A-w>"] = map_cmd("<C-W>c"):with_noremap():with_desc("Delete window"),
	["n|<leader>-"] = map_cmd("<C-W>s"):with_noremap():with_desc("Split window right"),
	["n|<leader>|"] = map_cmd("<C-W>v"):with_noremap():with_desc("Split window left"),
	["n|U"] = map_cmd("<C-r>"):with_noremap(),
	["nv|H"] = map_cmd("5h"):with_noremap(),
	["nv|J"] = map_cmd("5j"):with_noremap(),
	["nv|K"] = map_cmd("5k"):with_noremap(),
	["nv|L"] = map_cmd("5l"):with_noremap(),
	["nv|e"] = map_cmd("$"):with_noremap(),
	["nv|E"] = map_cmd("^"):with_noremap(),
	-- Suckless
	["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("edit: Toggle code fold"),
	["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
	["n|Y"] = map_cmd("y$"):with_desc("edit: Yank text to EOL"),
	["n|D"] = map_cmd("d$"):with_desc("edit: Delete text to EOL"),
	["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("edit: Next search result"),
	["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("edit: Prev search result"),
	-- ["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("edit: Join next line"),
	["n|<Esc>"] = map_cr("noh"):with_noremap():with_silent():with_desc("edit: Clear search highlight"),
	["n|<leader>h"] = map_cmd("<C-w>h"):with_noremap():with_desc("window: Focus left"),
	["n|<leader>l"] = map_cmd("<C-w>l"):with_noremap():with_desc("window: Focus right"),
	["n|<leader>j"] = map_cmd("<C-w>j"):with_noremap():with_desc("window: Focus down"),
	["n|<leader>k"] = map_cmd("<C-w>k"):with_noremap():with_desc("window: Focus up"),
	["t|<leader>h"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("window: Focus left"),
	["t|<leader>l"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("window: Focus right"),
	["t|<leader>j"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("window: Focus down"),
	["t|<leader>k"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("window: Focus up"),
	["n|<C-[>"] = map_cr("vertical resize -5"):with_silent():with_desc("window: Resize -5 vertically"),
	["n|<C-]>"] = map_cr("vertical resize +5"):with_silent():with_desc("window: Resize +5 vertically"),
	["n|<C-;>"] = map_cr("resize -2"):with_silent():with_desc("window: Resize -2 horizontally"),
	["n|<C-'>"] = map_cr("resize +2"):with_silent():with_desc("window: Resize +2 horizontally"),
	["n|<leader>qq"] = map_cr("wq"):with_desc("edit: Save file and quit"),
	["n|<leader>qQ"] = map_cr("q!"):with_desc("edit: Force quit"),
	["n|<leader>us"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),
	["n|<leader><tab><tab>"] = map_cr("tabnew"):with_noremap():with_silent():with_desc("tab: Create a new tab"),
	["n|<leader><tab>l"] = map_cr("tabnext"):with_noremap():with_silent():with_desc("tab: Move to next tab"),
	["n|<leader><tab>h"] = map_cr("tabprevious"):with_noremap():with_silent():with_desc("tab: Move to previous tab"),
	["n|<leader><tab>c"] = map_cr("tabonly"):with_noremap():with_silent():with_desc("tab: Only keep current tab"),
	-- Insert mode
	["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap():with_desc("edit: Delete previous block"),
	["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Move cursor to left"),
	["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("edit: Move cursor to line start"),
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
	-- ["i|<leader>qq"] = map_cmd("<Esc>:wq<CR>"):with_desc("edit: Save file and quit"),
	-- Command mode
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Left"),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Right"),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap():with_desc("edit: Home"),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap():with_desc("edit: End"),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap():with_desc("edit: Delete"),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap():with_desc("edit: Backspace"),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
		:with_noremap()
		:with_desc("edit: Complete path of current file"),
	-- Visual mode
	["v|<M-J>"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("edit: Move this line down"),
	["v|<M-K>"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("edit: Move this line up"),
	["v|<"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
	["v|>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),
}

bind.nvim_load_mapping(core_map)
