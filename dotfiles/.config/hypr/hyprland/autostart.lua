-- autostart.lua
-- Reference: https://wiki.hypr.land/Configuring/Basics/Autostart/
--

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d -r")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww restore")
    hl.exec_cmd("waybar")

    -- ── Add other apps you want to make it autostart ──
    -- e.g. (Start strawberry 1 second later)
    --
    -- hl.exec_cmd("sh -c 'sleep 1 && strawberry'")
end)
