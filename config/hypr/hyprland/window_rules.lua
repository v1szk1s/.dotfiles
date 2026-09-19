-- Window rules

hl.window_rule({
	match = { class = "^(firefox)$" },
	workspace = "2",
})

-- hl.window_rule({
--     match = { class = "^(rdesktop)$" },
--     workspace = "3",
-- })

-- hl.window_rule({
--     match = { class = "^(Zathura)$" },
--     workspace = "5",
-- })

hl.window_rule({
	match = { class = "^(gimp)$" },
	workspace = "7",
})

hl.window_rule({
	match = { class = "^(discord)$" },
	workspace = "8",
})

hl.window_rule({
	match = { class = "^(org.keepassxc.KeePassXC)$" },
	workspace = "9",
})

hl.window_rule({
	match = { class = "^(alacritty)$" },
	workspace = "1",
})

hl.window_rule({
	name = "nextcloud-topright",
	match = { class = "^com.nextcloud.desktopclient.nextcloud$" },
	float = true,
	size = { 400, 600 },
	move = { "cursor_x-300", "cursor_y" },
})

hl.window_rule({
	match = { class = "^(org%.kde%.kdenlive)$" },
	float = true,
})

hl.window_rule({
	match = { class = "^(org%.kde%.kdenlive)$" },
	center = true,
})
