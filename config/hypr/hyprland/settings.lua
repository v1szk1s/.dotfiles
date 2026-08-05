-- =========================
-- Hyprland Lua config
-- =========================

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 6,
		border_size = 0,
		-- col = {
		-- 	active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg",
		-- 	inactive_border = "rgba(595959aa)",
		-- },
		resize_on_border = false,
		allow_tearing = false,
		layout = "master",
	},

	-- dwindle = {
	-- 	pseudotile = true,
	-- 	preserve_split = true,
	-- },

	master = {
		new_status = "master",
		new_on_top = true,
		mfact = 0.5,
	},

	decoration = {
		rounding = 2,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 0.95,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 11,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = false,

		bezier = {
			{ name = "easeOutQuint", value = "0.23,1,0.32,1" },
			{ name = "easeInOutCubic", value = "0.65,0.05,0.36,1" },
			{ name = "linear", value = "0,0,1,1" },
			{ name = "almostLinear", value = "0.5,0.5,0.75,1.0" },
			{ name = "quick", value = "0.15,0,0.1,1" },
		},

		animation = {
			{ name = "global", value = "1, 10, default" },
			{ name = "border", value = "1, 5.39, easeOutQuint" },
			{ name = "windows", value = "1, 4.79, easeOutQuint" },
			{ name = "windowsIn", value = "1, 4.1, easeOutQuint, popin 87%" },
			{ name = "windowsOut", value = "1, 1.49, linear, popin 87%" },
			{ name = "fadeIn", value = "1, 1.73, almostLinear" },
			{ name = "fadeOut", value = "1, 1.46, almostLinear" },
			{ name = "fade", value = "1, 3.03, quick" },
			{ name = "layers", value = "1, 3.81, easeOutQuint" },
			{ name = "layersIn", value = "1, 4, easeOutQuint, fade" },
			{ name = "layersOut", value = "1, 1.5, linear, fade" },
			{ name = "fadeLayersIn", value = "1, 1.79, almostLinear" },
			{ name = "fadeLayersOut", value = "1, 1.39, almostLinear" },
			{ name = "workspaces", value = "1, 1.94, almostLinear, fade" },
			{ name = "workspacesIn", value = "1, 1.21, almostLinear, fade" },
			{ name = "workspacesOut", value = "1, 1.94, almostLinear, fade" },
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		focus_on_activate = true,
	},

	cursor = {
		hide_on_key_press = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},

	input = {
		kb_layout = "us,hu",
		kb_variant = ",",
		kb_model = "",
		kb_options = "grp:alt_space_toggle",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0.1,

		touchpad = {
			natural_scroll = true,
		},
	},

	ecosystem = {
		enforce_permissions = true,
		no_update_news = true,
	},
})
