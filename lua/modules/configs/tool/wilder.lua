return function() --命令模式下的补全  fzy-lua为依赖
	local wilder = require("wilder")
	local colors = require("modules.utils").get_palette()
	local icons = { ui = require("modules.utils.icons").get("ui") }

	wilder.setup({ modes = { ":", "/", "?" } })
	wilder.set_option("use_python_remote_plugin", 0)
	wilder.set_option("pipeline", {
		wilder.branch(
			wilder.cmdline_pipeline({ use_python = 0, fuzzy = 1, fuzzy_filter = wilder.lua_fzy_filter() }),
			wilder.vim_search_pipeline(),
			{
				wilder.check(function(_, x)
					return x == ""
				end),
				wilder.history(),
				wilder.result({
					draw = {
						function(_, x)
							return icons.ui.Calendar .. " " .. x
						end,
					},
				}),
			}
		),
	})

	local match_hl = require("modules.utils").hl_to_rgb("String", false, colors.green)

	local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		border = "rounded",
		highlights = {
			border = "Title", -- highlight to use for the border
			accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 0 }, { a = 0 }, { foreground = match_hl } }),
		},
		empty_message = wilder.popupmenu_empty_message_with_spinner(),
		highlighter = wilder.lua_fzy_highlighter(),
		left = {
			" ",
			wilder.popupmenu_devicons(),
			wilder.popupmenu_buffer_flags({
				flags = " a + ",
				icons = { ["+"] = icons.ui.Pencil, a = icons.ui.Indicator, h = icons.ui.File },
			}),
		},
		right = {
			" ",
			wilder.popupmenu_scrollbar(),
		},
	}))
	local wildmenu_renderer = wilder.wildmenu_renderer({
		highlighter = wilder.lua_fzy_highlighter(),
		apply_incsearch_fix = true,
		separator = " | ",
		left = { " ", wilder.wildmenu_spinner(), " " },
		right = { " ", wilder.wildmenu_index() },
	})
	-- wilder.set_option(-- 原装
	-- 	"renderer",
	-- 	wilder.renderer_mux({
	-- 		-- [":"] = popupmenu_renderer,
	-- 		["/"] = wildmenu_renderer,
	-- 		substitute = wildmenu_renderer,
	-- 	})
	-- )
	wilder.set_option(
		"renderer",
		wilder.wildmenu_renderer({
			highlights = {
				default = "StatusLine",
				accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
			},
			highlighter = {
				wilder.lua_pcre2_highlighter(), -- requires `luarocks install pcre2`
				wilder.lua_fzy_highlighter(), -- requires fzy-lua-native vim plugin found
			},
			separator = " · ",
			left = { " ", wilder.wildmenu_spinner(), " " },
			right = { " ", wilder.wildmenu_index() },
		})
	)
end
