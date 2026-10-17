hl.env("AQ_NO_MODIFIERS", "1")
-- hl.monitor({
-- 	output = "",
-- 	mode = "highres",
-- 	position = "auto-left",
-- 	scale = 1,
-- })

hl.monitor({
	output = "eDP-1",
	position = "0x0",

	mode = "preferred",
	scale = 2,

	-- mode = "2560x1440@60",
	-- scale = 1.25,

	-- mode = "3840x2160@60",
	-- scale = 2,

	-- mode = "1920x1080@60",
	-- scale = 1,
})

hl.monitor({
	-- output = "DP-1",
	output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. M27UP 0x01010101",
	-- mode = "3840x2160@60",
	-- mode = "1920x1080@144",
	-- mode = "highres",
	mode = "preferred",
	position = "auto-up",
	scale = 1.25,
})

-- hl.monitor({
-- 	output = "HDMI-A-1",
-- 	mode = "3840x2160@30.00Hz",
-- 	-- mode = "1920x1080@144",
-- 	position = "auto-up",
-- 	scale = 1,
-- })
