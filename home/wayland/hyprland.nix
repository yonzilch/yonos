{ config, hostname, lib, pkgs, ... }:
let
  inherit (import ../../hosts/${hostname}/env.nix)
    MonitorSettings
    ScaleLevel
    ;
in
with lib;
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    systemd.enable = false;
    xwayland.enable = true;
    extraConfig =
      concatStrings [
        ''
          ${MonitorSettings}
          env = CLUTTER_BACKEND, wayland
          env = ELECTRON_OZONE_PLATFORM_HINT, wayland
          env = GDK_BACKEND, wayland, x11
          env = GDK_SCALE, ${ScaleLevel}
          env = HYPRCURSOR_SIZE, 32
          env = HYPRCURSOR_THEME, Bibata-Modern-Ice
          env = _JAVA_AWT_WM_NONREPARENTING, 1
          env = MOZ_ENABLE_WAYLAND, 1
          env = NIXOS_OZONE_WL, 1
          env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
          env = QT_QPA_PLATFORM=wayland;xcb
          env = QT_QPA_PLATFORMTHEME, qt6ct
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
          env = SDL_VIDEODRIVER, wayland
          env = SSH_AUTH_SOCK, $XDG_RUNTIME_DIR/ssh-agent.socket
          env = XDG_CURRENT_DESKTOP, Hyprland
          env = XDG_SESSION_DESKTOP, Hyprland
          env = XDG_SESSION_TYPE, wayland

          exec-once = dbus-update-activation-environment --systemd --all
          exec-once = fcitx5 -d --replace
          exec-once = hypridle
          exec-once = nm-applet --indicator
          exec-once = pkill -q swww;sleep .5 && swww init
          exec-once = pkill -q swaync;sleep .5 && swaync
          exec-once = pkill waybar;sleep .5 && waybar
          exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = systemctl --user start hyprpolkitagent

          general {
            gaps_in = 6
            gaps_out = 8
            border_size = 2
            layout = dwindle
            resize_on_border = true
            col.active_border = rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0C}) 45deg
            col.inactive_border = rgb(${config.stylix.base16Scheme.base01})
          }
          input {
            kb_layout = us
            kb_model =
            kb_options =
            kb_rules =
            kb_variant =
            follow_mouse = 2
            touchpad {
              natural_scroll = no
              disable_while_typing = true
              scroll_factor = 0.8
            }
            accel_profile = flat
            sensitivity = 0
          }
          gestures {
            workspace_swipe = true
            workspace_swipe_fingers = 3
          }
          misc {
              disable_autoreload = true
              disable_hyprland_logo = true
              always_follow_on_dnd = true
              layers_hog_keyboard_focus = true
              animate_manual_resizes = false
              enable_swallow = true
              focus_on_activate = true
              vfr = true
          }
          animations {
            enabled = no
            bezier = wind, 0.05, 0.9, 0.1, 1.05
            bezier = winIn, 0.1, 1.1, 0.1, 1.1
            bezier = winOut, 0.3, -0.3, 0, 1
            bezier = liner, 1, 1, 1, 1
            animation = windows, 1, 6, wind, slide
            animation = windowsIn, 1, 6, winIn, slide
            animation = windowsOut, 1, 5, winOut, slide
            animation = windowsMove, 1, 5, wind, slide
            animation = border, 1, 1, liner
            animation = fade, 1, 10, default
            animation = workspaces, 1, 5, wind
          }
          decoration {
              active_opacity = 0.98
              inactive_opacity = 1.0
              fullscreen_opacity = 1.0
              rounding = 2
              blur {
                  enabled = true
                  size = 15
                  passes = 2
                  new_optimizations = true
                  xray = true
                  ignore_opacity = false
              }
              dim_inactive = false
          }
          device {
              name = epic-mouse-v1
              sensitivity = -0.5
          }
          dwindle {
              force_split = 0
              special_scale_factor = 0.8
              split_width_multiplier = 1.0
              use_active_for_splits = true
              pseudotile = yes
              preserve_split = yes
          }
          plugin {

          }
          xwayland {
            force_zero_scaling = true
          }

          $mainMod = SUPER

          bind = $mainMod, T, exec, alacritty
          bind = $mainMod, E, exec, nemo
          bind = $mainMod, S, exec, grim -g "$(slurp)" - | swappy -f -
          bind = $mainMod, Q, hy3:killactive
          bind = $mainMod SHIFT, M, exit
          bind = $mainMod SHIFT, F, togglefloating
          bind = ALT, SPACE, exec, fuzzel
          bind = $mainMod, F, fullscreen

          # Volume control
          bind = ,XF86AudioLowerVolume,exec,pamixer -ud 2 && pamixer --get-volume > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob
          bind = ,XF86AudioRaiseVolume,exec,pamixer -ui 2 && pamixer --get-volume > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob

          # mute sound
          bind = ,XF86AudioMute,exec,amixer sset Master toggle | sed -En '/\[on\]/ s/.*\[([0-9]+)%\].*/\1/ p; /\[off\]/ s/.*/0/p' | head -1 > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob

          # Playback control
          bind = ,XF86AudioPlay,exec, playerctl play-pause
          bind = ,XF86AudioNext,exec, playerctl next
          bind = ,XF86AudioPrev,exec, playerctl previous

          # Screen brightness
          bind = , XF86MonBrightnessUp, exec, brightnessctl s +5%
          bind = , XF86MonBrightnessDown, exec, brightnessctl s 5%-

          bind = ALT, E, exec , pkill fcitx5 -9;sleep 1;fcitx5 -d --replace; sleep 1;fcitx5-remote -r
          bind = ALT, W, exec, pkill waybar;sleep 1;waybar

          bind = $mainMod, L, exec, wleave

          # Move focus with mainMod + arrow keys
          #bind = $mainMod, left, movefocus, l
          #bind = $mainMod, right, movefocus, r
          #bind = $mainMod, up, movefocus, u
          #bind = $mainMod, down, movefocus, d

          # Scroll through existing workspaces with mainMod + scroll
          bindn = $mainMod, mouse_down, workspace, e-1
          bindn = $mainMod, mouse_up, workspace, e+1

          bindn = , mouse:272, hy3:focustab, mouse

          bindn = CTRL $mainMod, mouse:272, hy3:movefocus, l
          bindn = CTRL $mainMod, mouse:273, hy3:movefocus, r

          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow

          bind = $mainMod, left, hy3:movefocus, l
          bind = $mainMod, right, hy3:movefocus, r
          bind = $mainMod, up, hy3:movefocus, u
          bind = $mainMod, down, hy3:movefocus, d

          bind = $mainMod, A, hy3:makegroup, tab

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          bind = $mainMod, period, workspace, e+1
          bind = $mainMod, period, workspace, e+1

          bind = $mainMod, period, workspace, e+1
          bind = $mainMod, comma, workspace, e-1
          bind = $mainMod, slash, workspace, previous

          bind = $mainMod, Tab, togglespecialworkspace
          bind = $mainMod SHIFT, Tab, movetoworkspace, special

          bind = $mainMod SHIFT, left, movewindow, l
          bind = $mainMod SHIFT, right, movewindow, r
          bind = $mainMod SHIFT, up, movewindow, u
          bind = $mainMod SHIFT, down, movewindow, d

          bind = $mainMod SHIFT, h, movewindow, l
          bind = $mainMod SHIFT, l, movewindow, r
          bind = $mainMod SHIFT, j, movewindow, u
          bind = $mainMod SHIFT, k, movewindow, d

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # same as above, but doesnt switch to the workspace
          bind = $mainMod CTRL, 1, movetoworkspacesilent, 1
          bind = $mainMod CTRL, 2, movetoworkspacesilent, 2
          bind = $mainMod CTRL, 3, movetoworkspacesilent, 3
          bind = $mainMod CTRL, 4, movetoworkspacesilent, 4
          bind = $mainMod CTRL, 5, movetoworkspacesilent, 5
          bind = $mainMod CTRL, 6, movetoworkspacesilent, 6
          bind = $mainMod CTRL, 7, movetoworkspacesilent, 7
          bind = $mainMod CTRL, 8, movetoworkspacesilent, 8
          bind = $mainMod CTRL, 9, movetoworkspacesilent, 9
          bind = $mainMod CTRL, 0, movetoworkspacesilent, 10
          bind = $mainMod CTRL, left, workspace, -1
          bind = $mainMod CTRL, right, workspace, +1
          binds {
               workspace_back_and_forth = 1
               allow_workspace_cycles = 1
          }
          bind = $mainMod, R, submap, resize
          submap = resize
          binde = ,right,resizeactive,15 0
          binde = ,left,resizeactive,-15 0
          binde = ,up,resizeactive,0 -15
          binde = ,down,resizeactive,0 15
          binde = ,l,resizeactive,15 0
          binde = ,h,resizeactive,-15 0
          binde = ,k,resizeactive,0 -15
          binde = ,j,resizeactive,0 15
          bind = ,escape,submap,reset
          submap = reset
          bind = CTRL SHIFT, left, resizeactive,-15 0
          bind = CTRL SHIFT, right, resizeactive,15 0
          bind = CTRL SHIFT, up, resizeactive,0 -15
          bind = CTRL SHIFT, down, resizeactive,0 15
          bind = CTRL SHIFT, l, resizeactive, 15 0
          bind = CTRL SHIFT, h, resizeactive,-15 0
          bind = CTRL SHIFT, k, resizeactive, 0 -15
          bind = CTRL SHIFT, j, resizeactive, 0 15
          bind = ALT,Tab, hy3:movefocus, r
          bind = ALT SHIFT,Tab, hy3:movefocus, l
          bind = CONTROLALT, Return, exec, playerctl play-pause
          bind = CONTROLALT, right, exec, playerctl next
          bind = CONTROLALT, left, exec, playerctl previous
        ''
      ];
  };
}
