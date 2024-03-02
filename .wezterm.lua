local wezterm = require("wezterm")

local config = {}

local function scheme_for_appearance()
	local appearance = wezterm.gui.get_appearance()
	if appearance:find("Dark") then
		config.color_scheme = "Catppuccin Frappe"
	else
		config.color_scheme = "Catppuccin Latte"
	end
end

scheme_for_appearance()

local act = wezterm.action

config.initial_cols = 200
config.initial_rows = 50
config.window_background_opacity = 0.95
config.use_fancy_tab_bar = false
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 13.0
config.front_end = "WebGpu"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "1cell",
	right = 0,
	top = "1cell",
	bottom = "1cell",
}

config.keys = {
	{
		key = "P",
		mods = "CMD",
		action = act.ActivateCommandPalette,
	},
	{
		key = "g",
		mods = "CMD",
		action = act.PaneSelect({
			alphabet = "1234567890",
		}),
	},
	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "v",
		mods = "OPT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "OPT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

return config
