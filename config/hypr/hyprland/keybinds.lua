-- ========= System keybindings (original section) =========

-- Basic
hl.bind("SUPER + q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + q", hl.dsp.window.kill())
hl.bind("ALT + SHIFT + q", hl.dsp.exec_cmd("loginctl terminate-user " .. os.getenv("USER"))) -- or use "hyprctl dispatch exit" if you prefer

hl.bind("SUPER + Return", hl.dsp.exec_cmd("foot"))
-- hl.bind("SUPER + space", hl.dsp.exec_cmd("ncat -U /run/user/1000/walker/walker.sock"))
hl.bind("SUPER + space", hl.dsp.exec_cmd("hyprlauncher"))

hl.bind("SUPER + l", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + p", hl.dsp.exec_cmd("/home/mumu/.dotfiles/bin/monitor.sh"))

hl.bind("SUPER + s", hl.dsp.exec_cmd("select-sound-output.sh"))
hl.bind("SUPER + v", hl.dsp.exec_cmd("wg-menu.sh"))

-- System control (poweroff / reboot)
hl.bind("CTRL + ALT + SUPER + SHIFT + q", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind("CTRL + ALT + SUPER + SHIFT + r", hl.dsp.exec_cmd("reboot"))

-- Screenshot and keyboard toggle
hl.bind(
	"SUPER + SHIFT + s",
	hl.dsp.exec_cmd(
		"grim -g \"$(slurp)\" -t ppm - | satty --filename - --output-filename ~/Pictures/screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
	)
)
hl.bind("SUPER + SHIFT + c", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(
	"CTRL + SUPER + ALT + SHIFT + s",
	hl.dsp.exec_cmd(
		"grim -t ppm - | satty --filename - --output-filename ~/Pictures/screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
	)
)

-- Waybar toggle
hl.bind("SUPER + b", hl.dsp.exec_cmd("pkill waybar || waybar"))

-- Lockscreen / displays
-- hl.bind("", "XF86ScreenSaver", hl.dsp.exec_cmd("hyprlock"))
-- hl.bind("", "XF86Display", hl.dsp.exec_cmd("nwg-displays"))

-- OSD helper
-- We can't do dynamic shell expansion in pure Lua as cleanly as in hyprlang,
-- so we rely on a small wrapper script or environment variable.
-- If you have a script `osdclient.sh` that does this, use:
-- hl.bind(..., hl.dsp.exec_cmd("/path/to/osdclient.sh ..."))
-- Otherwise, you can hardcode a monitor name or simplify.

-- For illustration, assuming you create a script /home/mumu/.dotfiles/bin/osdclient.sh:
-- #!/usr/bin/env bash
-- exec swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')" "$@"
--
local function osd(cmd)
	return hl.dsp.exec_cmd("swayosd-client " .. cmd)
end

-- Laptop multimedia keys (volume + brightness with OSD)
hl.bind("XF86AudioRaiseVolume", osd("--output-volume raise"), { repeating = true })
hl.bind("XF86AudioLowerVolume", osd("--output-volume lower"), { repeating = true })
hl.bind("XF86AudioMute", osd("--output-volume mute-toggle"))
hl.bind("XF86AudioMicMute", osd("--input-volume mute-toggle"))
hl.bind("XF86MonBrightnessUp", osd("--brightness raise"), { repeating = true })
hl.bind("XF86MonBrightnessDown", osd("--brightness lower"), { repeating = true })

-- Precise 1% multimedia adjustments with Shift
hl.bind("SHIFT + XF86AudioRaiseVolume", osd("--output-volume +1"))
hl.bind("SHIFT + XF86AudioLowerVolume", osd("--output-volume -1"))
hl.bind("SHIFT + XF86MonBrightnessUp", osd("--brightness +1"))
hl.bind("SHIFT + XF86MonBrightnessDown", osd("--brightness -1"))

-- Playerctl media keys (with OSD)
hl.bind("XF86AudioNext", osd("--playerctl next"))
hl.bind("XF86AudioPause", osd("--playerctl play-pause"))
hl.bind("XF86AudioPlay", osd("--playerctl play-pause"))
hl.bind("XF86AudioPrev", osd("--playerctl previous"))
