local wezterm = require("wezterm")

local config = {}

local function scheme_for_appearance()
	local appearance = wezterm.gui.get_appearance()
	if appearance:find("Dark") then
		config.color_scheme = "tokyonight-storm"
	else
		config.color_scheme = "tokyonight-day"
	end
end

scheme_for_appearance()

local act = wezterm.action

config.initial_cols = 200
config.initial_rows = 50
config.window_background_opacity = 0.9
config.use_fancy_tab_bar = false
config.font = wezterm.font("FiraCode Nerd Font")
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
		key = "]",
		mods = "CMD",
		action = act.ActivateTabRelative(1),
	},

	{
		key = "w",
		mods = "CMD",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "\\",
		mods = "CMD",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 35 },
		}),
	},
	{
		key = "h",
		mods = "OPT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "]",
		mods = "CMD",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "CMD",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "H",
		mods = "CMD",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "L",
		mods = "CMD",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "L",
		mods = "CMD",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "r",
		mods = "CMD",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text("!!\n")
		end),
	},
}

for i = 1, 5 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "OPT",
		action = act.ActivateTab(i - 1),
	})
end

return config
