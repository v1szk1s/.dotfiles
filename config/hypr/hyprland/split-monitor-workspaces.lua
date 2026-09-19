package.path = package.path .. ";./?.lua;./?/init.lua"

local mainMod = "ALT"

local smw_ok, smw = pcall(require, "plugins.split-monitor-workspaces")

if smw_ok then
	smw.setup({
		workspace_count = 9,
		enable_wrapping = false,
		-- link_monitors = true,
		-- enable_persistent_workspaces = true,
		monitor_priority = { "HDMI-A-1", "DP-1", "eDP-1" },
	})

	for i = 1, smw.get_amount_of_workspaces() do
		local key = tostring(i % 10) -- 10 becomes key 0

		hl.bind(mainMod .. " + " .. key, smw.workspace(key))
		hl.bind(mainMod .. " + SHIFT + " .. key, smw.move_to_workspace(key))
	end

	hl.gesture({
		fingers = 3,
		direction = "right",
		action = smw.workspace("-1"),
	})

	hl.gesture({
		fingers = 3,
		direction = "left",
		action = smw.workspace("+1"),
	})
else
	for i = 1, 9 do
		local key = tostring(i)

		hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = key }))

		hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = key }))
	end
end
