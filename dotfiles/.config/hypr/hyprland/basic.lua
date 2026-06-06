-- basic.lua
-- Reference: https://wiki.hypr.land/Configuring/Basics/Variables/
--            https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

local colors = require('hyprland.themes.catppuccin-mocha')

-- ── Environment Variables ──────────────────────────────────────────────────
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- ── Animation Curves (bezier) ──────────────────────────────────────────────
-- Format: hl.curve(NAME, { type = "bezier", points = { {x0,y0}, {x1,y1} } })
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0,    0},    {1,    1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5,  0.5},  {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1,  1}    } })

-- ── Animation Entries ──────────────────────────────────────────────────────
-- Format: hl.animation({ leaf = NAME, enabled, speed, bezier/spring, [style] })
hl.animation({ leaf = "global",              enabled = true, speed = 10,   bezier = "default"      })
hl.animation({ leaf = "border",              enabled = true, speed = 5.39, bezier = "easeOutQuint"  })
hl.animation({ leaf = "windows",             enabled = true, speed = 4.79, bezier = "easeOutQuint"  })
hl.animation({ leaf = "windowsIn",           enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%"  })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 1.49, bezier = "linear",        style = "popin 87%"  })
hl.animation({ leaf = "fadeIn",              enabled = true, speed = 1.73, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeOut",             enabled = true, speed = 1.46, bezier = "almostLinear"  })
hl.animation({ leaf = "fade",                enabled = true, speed = 3.03, bezier = "quick"         })
hl.animation({ leaf = "layers",              enabled = true, speed = 3.81, bezier = "easeOutQuint"  })
hl.animation({ leaf = "layersIn",            enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade"       })
hl.animation({ leaf = "layersOut",           enabled = true, speed = 1.5,  bezier = "linear",       style = "fade"       })
hl.animation({ leaf = "fadeLayersIn",        enabled = true, speed = 1.79, bezier = "almostLinear"  })
hl.animation({ leaf = "fadeLayersOut",       enabled = true, speed = 1.39, bezier = "almostLinear"  })
hl.animation({ leaf = "workspaces",          enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade"       })
hl.animation({ leaf = "workspacesIn",        enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade"       })
hl.animation({ leaf = "workspacesOut",       enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade"       })
hl.animation({ leaf = "zoomFactor",          enabled = true, speed = 7,    bezier = "quick"         })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 2,    bezier = "almostLinear", style = "fade"       })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2,    bezier = "almostLinear", style = "fade"       })

-- ── Main Configuration Block ──────────────────────────────────────────────
hl.config({
    animations = {
        enabled = true,
    },

    debug = {
        suppress_errors  = true,
        watchdog_timeout = 0,
    },

    decoration = {
        active_opacity     = 1.0,
        inactive_opacity   = 1.0,
        fullscreen_opacity = 1.0,
        dim_inactive       = false,
        rounding           = 6,
        blur = {
            enabled = false,
        },
        shadow = {
            enabled = false,
        },
    },

    ecosystem = {
        no_donation_nag = true,
        no_update_news  = true,
    },

    general = {
        gaps_in     = 1,
        gaps_out    = 1,
        border_size = 1,
        col = {
            active_border   = colors.lavender,
            inactive_border = colors.base,
        },
        layout = "hy3",
    },

    gestures = {
        workspace_swipe                    = true,
        workspace_swipe_fingers            = 3,
        workspace_swipe_distance           = 250,
        workspace_swipe_invert             = true,
        workspace_swipe_min_speed_to_force = 15,
        workspace_swipe_cancel_ratio       = 0.5,
        workspace_swipe_create_new         = false,
    },

    input = {
        follow_mouse                = 1,
        float_switch_override_focus = 2,
        numlock_by_default          = false,
        sensitivity                 = 0,
        touchpad = {
            disable_while_typing = true,
            natural_scroll       = true,
            scroll_factor        = 0.5,
        },
    },

    misc = {
        always_follow_on_dnd           = true,
        disable_autoreload             = false,
        disable_hyprland_logo          = true,
        disable_hyprland_qtutils_check = true,
        disable_splash_rendering       = true,
        disable_xdg_env_checks         = true,
        enable_anr_dialog              = false,
        enable_swallow                 = true,
        focus_on_activate              = true,
        initial_workspace_tracking     = 0,
        key_press_enables_dpms         = false,
        layers_hog_keyboard_focus      = true,
        mouse_move_enables_dpms        = false,
        vfr                            = true,
    },

    -- ── hy3 Plugin Configuration ───────────────────────────────────────────
    -- Color format converted from rgb(RRGGBB) to 0xffRRGGBB (Lua ARGB integer)
    -- If hy3's Lua configuration API differs, refer to the hy3 documentation
    plugin = {
        hy3 = {
            no_gaps_when_only    = 0,
            node_collapse_policy = 1,
            group_inset          = 10,
            tab_first_window     = true,
            tabs = {
                colors = {
                    -- active
                    active          = colors.mantle,  -- rgb(b4befe)
                    active_border   = colors.subtext0,  -- rgb(313244)
                    active_text     = colors.lavender,  -- rgb(181825)
                    -- inactive
                    inactive        = colors.mantle,  -- rgb(181825)
                    inactive_border = colors.surface1,  -- rgb(313244)
                    inactive_text   = colors.lavender,  -- rgb(b4befe)
                    -- urgent
                    urgent          = 0xfff2cdcd,  -- rgb(f2cdcd)
                    urgent_border   = 0xff313244,  -- rgb(313244)
                    urgent_text     = 0xff181825,  -- rgb(181825)
                },
                from_top     = false,
                height       = 15,
                padding      = 3,
                render_text  = true,
                rounding     = 6,
                text_center  = true,
                text_font    = "Sarasa Gothic SC",
                text_height  = 10,
                text_padding = 1,
            },
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})
