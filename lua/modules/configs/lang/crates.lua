return function() --管理crates.io依赖项
	local icons = {
		diagnostics = require("modules.utils.icons").get("diagnostics", true),
		git = require("modules.utils.icons").get("git", true),
		misc = require("modules.utils.icons").get("misc", true),
		ui = require("modules.utils.icons").get("ui", true),
		kind = require("modules.utils.icons").get("kind", true),
	}

	require("crates").setup({
		smart_insert = true,
		insert_closing_quote = true,
		avoid_prerelease = true,
		autoload = true,
		autoupdate = true,
		autoupdate_throttle = 250,
		loading_indicator = true,
		date_format = "%Y-%m-%d",
		thousands_separator = ",",
		notification_title = "Crates",
		curl_args = { "-sL", "--retry", "1" },
		disable_invalid_feature_diagnostic = false,
		text = {
			loading = " " .. icons.misc.Watch .. "Loading",
			version = " " .. icons.ui.Check .. "%s",
			prerelease = " " .. icons.diagnostics.Warning_alt .. "%s",
			yanked = " " .. icons.diagnostics.Error .. "%s",
			nomatch = " " .. icons.diagnostics.Question .. "No match",
			upgrade = " " .. icons.diagnostics.Hint_alt .. "%s",
			error = " " .. icons.diagnostics.Error .. "Error fetching crate",
		},
		popup = {
			autofocus = false,
			hide_on_select = true,
			copy_register = '"',
			style = "minimal",
			border = "rounded",
			show_version_date = true,
			show_dependency_version = true,
			max_height = 30,
			min_width = 20,
			padding = 1,
			text = {
				title = icons.ui.Package .. "%s",
				description = "%s",
				created_label = icons.misc.Added .. "created" .. "        ",
				created = "%s",
				updated_label = icons.misc.ManUp .. "updated" .. "        ",
				updated = "%s",
				downloads_label = icons.ui.CloudDownload .. "downloads      ",
				downloads = "%s",
				homepage_label = icons.misc.Campass .. "homepage       ",
				homepage = "%s",
				repository_label = icons.git.Repo .. "repository     ",
				repository = "%s",
				documentation_label = icons.diagnostics.Information_alt .. "documentation  ",
				documentation = "%s",
				crates_io_label = icons.ui.Package .. "crates.io      ",
				crates_io = "%s",
				categories_label = icons.kind.Class .. "categories     ",
				keywords_label = icons.kind.Keyword .. "keywords       ",
				version = "  %s",
				prerelease = icons.diagnostics.Warning_alt .. "%s prerelease",
				yanked = icons.diagnostics.Error .. "%s yanked",
				version_date = "  %s",
				feature = "  %s",
				enabled = icons.ui.Play .. "%s",
				transitive = icons.ui.List .. "%s",
				normal_dependencies_title = icons.kind.Interface .. "Dependencies",
				build_dependencies_title = icons.misc.Gavel .. "Build dependencies",
				dev_dependencies_title = icons.misc.Glass .. "Dev dependencies",
				dependency = "  %s",
				optional = icons.ui.BigUnfilledCircle .. "%s",
				dependency_version = "  %s",
				loading = " " .. icons.misc.Watch,
			},
		},
		src = {
			insert_closing_quote = true,
			text = {
				prerelease = " " .. icons.diagnostics.Warning_alt .. "pre-release ",
				yanked = " " .. icons.diagnostics.Error_alt .. "yanked ",
			},
		},
	})

	-- Set buffer-local keymaps
	require("lang.crates-keymap")
end
