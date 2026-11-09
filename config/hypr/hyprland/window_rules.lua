-- Window rules

hl.window_rule({
	match = { class = "^(firefox)$" },
	workspace = "2 silent",
})

-- hl.window_rule({
--     match = { class = "^(rdesktop)$" },
--     workspace = "3 silent",
-- })

-- hl.window_rule({
--     match = { class = "^(Zathura)$" },
--     workspace = "5 silent",
-- })

-- hl.window_rule({
-- 	match = { class = "^(gimp)$" },
-- 	workspace = "7 silent",
-- })

hl.window_rule({
	match = { class = "^(discord)$" },
	workspace = "8 silent",
})

-- Main KeePassXC window -> workspace 9
hl.window_rule({
	match = {
		class = "^org.keepassxc.KeePassXC$",
		title = "^(.+ - )?KeePassXC$",
	},
	workspace = "9 silent",
})

-- KeePassXC dialogs/popups: leave them on the currently active workspace
hl.window_rule({
	match = {
		class = "^org.keepassxc.KeePassXC$",
		title = "^(KeePassXC - Browser Access Request|Unlock Database - KeePassXC)$",
	},
	workspace = "unset",
	float = true,
})

-- hl.window_rule({
-- 	match = { class = "^(org.keepassxc.KeePassXC)$" },
-- 	workspace = "9 silent",
-- })

hl.window_rule({
	match = { class = "^(alacritty)$" },
	workspace = "1 silent",
})

-- hl.window_rule({
-- 	name = "nextcloud-topright",
-- 	match = { class = "^com.nextcloud.desktopclient.nextcloud$" },
-- 	float = true,
-- 	size = { 400, 600 },
-- 	move = { "cursor_x-300", "cursor_y" },
-- })

-- hl.window_rule({
-- 	match = { class = "^(org%.kde%.kdenlive)$" },
-- 	float = true,
-- })

-- hl.window_rule({
-- 	match = { class = "^(org%.kde%.kdenlive)$" },
-- 	center = true,
-- })

hl.window_rule({
	match = {
		class = "foot",
		title = ".*[float].*",
	},
	size = "monitor_w*0.8 monitor_h*0.8",
	float = true,
})
