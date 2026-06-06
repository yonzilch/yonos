-- bind.lua
-- Reference: https://wiki.hypr.land/Configuring/Basics/Binds/
--            https://wiki.hypr.land/Configuring/Basics/Dispatchers/
--

-- ── Binds Configuration ────────────────────────────────────────────────────
hl.config({
    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles   = true,
    },
})

-- ── hy3 Plugin Dispatchers ─────────────────────────────────────────────────
-- Reference: https://github.com/outfoxxed/hy3
local hy3 = hl.plugin.hy3

-- ── App Launcher ──────────────────────────────────────────────────────────
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("fuzzel"), { release = true })

-- ── Restart Programs ──────────────────────────────────────────────────────
-- Multiple commands wrapped with sh -c to ensure shell parses semicolons/pipes
hl.bind("CTRL + ALT + I",
    hl.dsp.exec_cmd("sh -c 'pkill fcitx5 -9; sleep 1; fcitx5 -d --replace; sleep 1; fcitx5-remote -r'"))
hl.bind("CTRL + ALT + N",
    hl.dsp.exec_cmd("swaync-client -rs"))
hl.bind("CTRL + ALT + B",
    hl.dsp.exec_cmd("sh -c 'pkill waybar; sleep 1; waybar'"))

-- ── Quick Launch ──────────────────────────────────────────────────────────
hl.bind("SUPER + E",              hl.dsp.exec_cmd("nemo"))
hl.bind("CTRL + SUPER + Q",       hl.dsp.exec_cmd("wleave"))
hl.bind("SUPER + T",              hl.dsp.exec_cmd("alacritty"))
-- Screenshots
hl.bind("SUPER + S",              hl.dsp.exec_cmd("sh ~/.config/waybar/scripts/Screenshot-Area.sh"))
hl.bind("SUPER + ALT + S",        hl.dsp.exec_cmd("sh ~/.config/waybar/scripts/Screenshot-Fullscreen.sh"))
hl.bind("SUPER + CTRL + S",       hl.dsp.exec_cmd("sh ~/.config/waybar/scripts/Screenshot-Hyprland-Window.sh"))
hl.bind("SUPER + CTRL + ALT + S", hl.dsp.exec_cmd("sh ~/.config/waybar/scripts/Screenshot-OCR.sh"))

-- ── Window Operations ─────────────────────────────────────────────────────
hl.bind("SUPER + F",       hl.dsp.window.fullscreen())
hl.bind("SUPER + Q",       hy3.kill_active())              -- hy3 version of killactive
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

-- ── Workspace Jump (Absolute Number) ──────────────────────────────────────
for i = 1, 9 do
    hl.bind("SUPER + " .. i,        hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + CTRL + " .. i, hl.dsp.window.move({ workspace = i, silent = true }))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
-- Workspace 10 (key 0)
hl.bind("SUPER + 0",        hl.dsp.focus({ workspace = 10 }))
hl.bind("SUPER + CTRL + 0", hl.dsp.window.move({ workspace = 10, silent = true }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Mouse wheel to switch workspaces (window follows)
hl.bind("SUPER + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + SHIFT + mouse:275",  hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + mouse:276",  hl.dsp.window.move({ workspace = "e-1" }))

-- ── Special Workspace (scratchpad) ────────────────────────────────────────
hl.bind("SUPER + Grave",         hl.dsp.workspace.toggle_special("S"))
hl.bind("SUPER + CTRL + Grave",  hl.dsp.window.move({ workspace = "S", silent = true }))
hl.bind("SUPER + SHIFT + Grave", hl.dsp.window.move({ workspace = "S" }))

-- ── Workspace Switching (Relative) ────────────────────────────────────────
hl.bind("SUPER + CTRL + left",  hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + CTRL + right", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + CTRL + H",    hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + CTRL + L",    hl.dsp.focus({ workspace = "+1" }))

-- ── Window Focus Movement ─────────────────────────────────────────────────
-- Arrow keys
hl.bind("SUPER + left",  hy3.move_focus("l"))
hl.bind("SUPER + right", hy3.move_focus("r"))
hl.bind("SUPER + up",    hy3.move_focus("u"))
hl.bind("SUPER + down",  hy3.move_focus("d"))
-- Vim keys (Super+Alt)
hl.bind("SUPER + ALT + H", hy3.move_focus("l"))
hl.bind("SUPER + ALT + L", hy3.move_focus("r"))
hl.bind("SUPER + ALT + K", hy3.move_focus("u"))
hl.bind("SUPER + ALT + J", hy3.move_focus("d"))

-- ── Window Directional Movement ───────────────────────────────────────────
-- Arrow keys
hl.bind("SUPER + SHIFT + left",  hy3.move_window("l"))
hl.bind("SUPER + SHIFT + right", hy3.move_window("r"))
hl.bind("SUPER + SHIFT + up",    hy3.move_window("u"))
hl.bind("SUPER + SHIFT + down",  hy3.move_window("d"))
-- Vim keys
hl.bind("SUPER + SHIFT + H", hy3.move_focus("l"))
hl.bind("SUPER + SHIFT + L", hy3.move_focus("r"))
hl.bind("SUPER + SHIFT + K", hy3.move_focus("u"))
hl.bind("SUPER + SHIFT + J", hy3.move_focus("d"))

-- ── Mouse Drag / Workspace Scrolling ──────────────────────────────────────
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + mouse:275",  hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse:276",  hl.dsp.focus({ workspace = "e-1" }))

-- ── Tab focus actions
-- By Alt + Tab
hl.bind("ALT + Tab",          hy3.focus_tab({ direction = "l", mouse = "ignore", wrap = true }))
hl.bind("ALT + SHIFT + Tab",  hy3.focus_tab({ direction = "r", mouse = "ignore", wrap = true }))
-- By Mouse (non_consuming: does not consume the event)
hl.bind("mouse_down",  hy3.focus_tab({ direction = "l", mouse = "require_hovered", wrap = true }),
    { non_consuming = true })
hl.bind("mouse_up",    hy3.focus_tab({ direction = "r", mouse = "require_hovered", wrap = true }),
    { non_consuming = true })


-- ── Brightness Control ────────────────────────────────────────────────────
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness +5"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -5"),
    { locked = true, repeating = true })

-- ── Media Control ─────────────────────────────────────────────────────────
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
-- Media control bonus (keyboard shortcuts)
hl.bind("CTRL + ALT + Return", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("CTRL + ALT + right",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("CTRL + ALT + left",   hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- ── Lock Indicator Lights (SwayOSD) ───────────────────────────────────────
hl.bind("Caps_Lock",   hl.dsp.exec_cmd("swayosd-client --caps-lock"))
hl.bind("Scroll_Lock", hl.dsp.exec_cmd("swayosd-client --scroll-lock"))
hl.bind("Num_Lock",    hl.dsp.exec_cmd("swayosd-client --num-lock"))

-- ── Volume Control ────────────────────────────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +2"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -2"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),
    { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
    { locked = true })
-- Volume control bonus
hl.bind("CTRL + ALT + up",      hl.dsp.exec_cmd("swayosd-client --output-volume +2"),
    { locked = true, repeating = true })
hl.bind("CTRL + ALT + down",    hl.dsp.exec_cmd("swayosd-client --output-volume -2"),
    { locked = true, repeating = true })
