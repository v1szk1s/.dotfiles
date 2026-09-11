-- hyprland.lua
local mainMod = "ALT"

-- ========= Workspace switching =========
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + 0", hl.dsp.workspace.toggle_special())

hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ monitor = "mon:-1" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ monitor = "mon:+1" }))

-- ========= Focus monitor =========
hl.bind(mainMod .. " + comma", hl.dsp.focus({ monitor = "mon:-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = "mon:+1" }))

-- ========= Layout / master controls =========
hl.bind(mainMod .. " + m", hl.dsp.layout("resize 0.05"))
hl.bind(mainMod .. " + i", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + d", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + Return", hl.dsp.layout("swapwithmaster"))

-- ========= Window states =========
hl.bind("SUPER + f", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))

-- ========= Groups / misc window actions =========
hl.bind(mainMod .. " + t", hl.dsp.group.toggle())
hl.bind(mainMod .. " + u", hl.dsp.window.move({ out_of_group = true }))

hl.bind(mainMod .. " + p", hl.dsp.window.pin())
hl.bind(mainMod .. " + c", hl.dsp.window.center())

hl.bind(mainMod .. " + n", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + p", hl.dsp.window.cycle_next({ prev = true }))

hl.bind(mainMod .. " + i", hl.dsp.group.next())
hl.bind(mainMod .. " + o", hl.dsp.group.prev())

-- ========= Move window / group (vim-style) =========
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- ========= Resize active window =========
hl.bind(mainMod .. " + SHIFT + o", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + i", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))

-- ========= Focus movement (vim-style) =========
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- ========= Mouse binds =========
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ========= Resize submap =========
hl.bind(mainMod .. " + r", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
	hl.bind("l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
end)

-- ========= Move submap =========
hl.bind(mainMod .. " + m", hl.dsp.submap("move"))

hl.define_submap("move", function()
	hl.bind("h", hl.dsp.window.move({ x = -50, y = 0, relative = true }))
	hl.bind("l", hl.dsp.window.move({ x = 50, y = 0, relative = true }))
	hl.bind("k", hl.dsp.window.move({ x = 0, y = -50, relative = true }))
	hl.bind("j", hl.dsp.window.move({ x = 0, y = 50, relative = true }))

	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
end)
