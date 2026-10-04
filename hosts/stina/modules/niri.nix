{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];

  # logind
  services.logind = {
    enable = true;
    settings.Login = {
      HandlePowerKey = "poweroff";
    };
  };

  # ly
  services.displayManager.ly = {
    enable = true;
    settings = {
      battery_id = "BAT0";
      bigclock = "en";
      bigclock_12hr = false;
      clear_password = true;
    };
  };

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs = {
    niri = {
      package = pkgs.niri-unstable;
      enable = true;
    };
  };

  environment.variables = {
    # For applications that don't use portals by default
    # These environment variables set using portals for older (GTK_USE_PORTAL) and newer (GDK_DEBUG) apps
    GTK_USE_PORTAL = "1"; # legacy
    GDK_DEBUG = "portals"; # termfilechooser
    QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
  };

  # Authentication agent needed
  security.polkit.enable = true;

  # XDG portal integration
  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
        settings = {
          screencast = {
            output_name = "eDP-1";
            chooser_type = "simple";
            chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          };
        };
      };
      # Force this config to remove the gnome portal from extraPortals -> this fixes the slow startup issue with waybar and co.
      extraPortals =
        with pkgs;
        lib.mkForce [
          xdg-desktop-portal-termfilechooser
          xdg-desktop-portal-umbriel
          xdg-desktop-portal-gtk
        ];
      config = {
        common = {
          default = [ "*" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "umbriel" ];
        };
      };
      # xdgOpenUsePortal = true;
    };
  };
  home-manager.users.lily.xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    enable = true;
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      create_help_file=1
      default_dir=$HOME
      env=TERMCMD='kitty -T "terminal filechooser"'
      open_mode=suggested
      save_mode=last
    '';
  };

  home-manager.users.lily = {
    programs = {
      # noctalia
      noctalia = {
        enable = true;
        settings = {
          shell = {
            font_family = "NotoMono Nerd Font";
            lang = "en";
            show_location = false;
            shadow = {
              direction  ="center";
            };
            panel = {
              clipboard_placement = "attached";
              borders = false;
              shadow = false;
            };
            launcher = {
              categories = false;
              compact = true;
              fetch_exchange_rtes = false;
            };
            screenshot = {
              save_to_file = false;
              copy_to_clipboard = true;
            };
          };
          lockscreen = {
            enabled = true;
            fingerprint = false;
            blurred_desktop = true;
            blur_intensity = 1;
            transition = "fade";
          };
          lockscreen_widgets = {
            enabled = true;
            widget."lockscreen-login-box@DP-1".settings = {
              layout = "compact";
              show_media = false;
              show_login_button = false;
              input_radius = 32;
              center_password_text = true;
            };
          };
          keybinds = {
            left = [ "left" "h" ];
            right = [ "right" "l" ];
            up = [ "up" "k" ];
            down = [ "down" "j" ];
          };
          wallpaper = {
            enabled = true;
            default.path = ../resources/bark.png;
            fill_mode = "fit";
          };
          bar = {
            default = {
              start  = [
                "workspaces"
              ];
              center = ["clock"];
              end = [
                "clipboard"
                "network"
                "volume"
                "brightness"
                "battery"
              ];
              widget_spacing = 15;
            };
          };
          theme = {
            mode = "dark";
            shell_mode = "follow";
            source = "commmunity";
            community_palette = "Neon Surf";
          };
          osd = {
            border = false;
            position = "bottom_center";
            kinds = {
              lock_keys = false;
            };
          };
          weather = {
            enabled = false;
          };
          location = {
            auto_locate = false;
          };
          idle = {
            behavior = {
              lock = {
                timeout = 600;
                action = "lock";
                enabled = true;
              };
              screen-off = {
                timeout = 660;
                action = "screen_off";
                enabled = true;
              };
              suspend = {
                timeout = 900;
                action = "lock_and_suspend";
                enabled = true;
              };
            };
          };
        };
      };
      # niri
      niri = {
        settings = {
          spawn-at-startup = [
            {
              command = ["noctalia"];
            }
          ];
          recent-windows = {
            highlight = {
              active-color = "#ffffff";
              padding = 10;
              corner-radius = 5;
            };
          };
          outputs = {
            HDMI-A-1 = {
              enable = true;
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.00;
              };
              position = {
                x = 1920;
                y = 0;
              };
            };
            eDP-1 = {
              enable = true;
              mode = {
                height = 1080;
                width = 1920;
                refresh = 60.003;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
          };
          gestures.hot-corners.enable = false;
          input = {
            power-key-handling.enable = false;
            keyboard = {
              xkb = {
                layout = "at";
              };
            };
            touchpad = {
              enable = true;
              tap = true;
              natural-scroll = true;
            };
            mouse = {
              enable = true;
            };
            trackpoint = {
              enable = true;
            };
          };
          layout = {
            background-color = "transparent";
            center-focused-column = "never";
            preset-column-widths = [
              { proportion = 0.3333; }
              { proportion = 0.5; }
              { proportion = 0.6667; }
            ];
            default-column-width = {
              proportion = 0.5;
            };
            border = {
              enable = true;
              width = 2;
              active.color = "#ffffff";
              inactive.color = "#101010";
            };
            focus-ring = {
              enable = false;
            };
            shadow = {
              enable = true;
              spread = 5;
              softness = 30;
              offset = {
                x = 0;
                y = 5;
              };
              color = "#000000";
            };
          };
          window-rules = [
            {
              geometry-corner-radius = {
                bottom-left = 10.5;
                bottom-right = 10.5;
                top-left = 10.5;
                top-right = 10.5;
              };
              clip-to-geometry = true;
            }
            # I've tried getting this to work
            # But I believe that it doesn't actually start yazi with that title
            # open-floating only applies when the windo was opened sooo
            /*{
              matches = [
                {
                  title = "yazi.*";
                  app-id = "kitty";
                }
              ];
              open-floating = true;
            }*/
            {
              matches = [
                {
                  title = "Change.*Colour";
                  app-id = "Gimp.*";
                }
              ];
              open-floating = true;
            }
            {
              matches = [
                {
                  title = "Quit GIMP";
                  app-id = "Gimp.*";
                }
              ];
              open-floating = true;
            }
            {
              matches = [
                {
                  app-id = "PacketTracer";
                }
              ];
              excludes = [
                {
                  title = "Cisco Packet Tracer.*";
                }
              ];
              open-floating = true;
            }
            {
              matches = [
                {
                  app-id = "PacketTracer";
                  title = "Cisco Packet Tracer.*";
                }
              ];
              open-maximized = true;
            }
            {
              matches = [
                {
                  app-id = "firefox";
                  title = "Picture-in-Picture";
                }
              ];
              open-floating = true;
            }
          ];
          environment = {
            XDG_CURRENT_DESKTOP = "niri";
          };

          hotkey-overlay.skip-at-startup = true;
          prefer-no-csd = true;
          animations = {
            enable = true;
            workspace-switch = {
              enable = true;
              kind = {
                spring = {
                  damping-ratio = 1.00;
                  stiffness = 900;
                  epsilon = 0.0001;
                };
              };
            };
          };
          cursor = {
            size = 24;
            theme = "Bibata-Modern-Classic";
          };
          switch-events = {
            lid-close.action.spawn = [
              "systemctl"
              "suspend"
            ];
            lid-open.action.spawn = [ "hyprlock" ];
          };
          binds = {
            "Alt+Q".action.spawn = [ "kitty" ];
            "Alt+E".action.spawn = [
              "kitty"
              "yazi"
            ];
            "Alt+Backspace".action.close-window = [ ];
            "Alt+Return".action.maximize-window-to-edges = [ ];
            "Alt+Shift+Return".action.fullscreen-window = [ ];

            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "noctalia"
                "msg"
                "volume-up"
              ];
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "noctalia"
                "msg"
                "volume-down"
              ];
            };

            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn = [
                "noctalia"
                "msg"
                "volume-mute"
              ];
            };

            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action.spawn = [
                "noctalia"
                "msg"
                "mic-mute"
              ];
            };

            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [
                "noctalia"
                "msg"
                "brightness-up"
              ];
            };

            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [
                "noctalia"
                "msg"
                "brightness-up"
              ];
            };

            # Window navigation
            "Alt+H".action.focus-column-left = [ ];
            "Alt+J".action.focus-window-down = [ ];
            "Alt+K".action.focus-window-up = [ ];
            "Alt+L".action.focus-column-right = [ ];

            # Moving windows
            "Alt+Shift+H".action.move-column-left = [ ];
            "Alt+Shift+J".action.move-window-down = [ ];
            "Alt+Shift+K".action.move-window-up = [ ];
            "Alt+Shift+L".action.move-column-right = [ ];

            # Resizing windows
            "Alt+Ctrl+H".action.set-column-width = [ "-10%" ];
            "Alt+Ctrl+J".action.set-window-height = [ "+10%" ];
            "Alt+Ctrl+K".action.set-window-height = [ "-10%" ];
            "Alt+Ctrl+L".action.set-column-width = [ "+10%" ];

            # Workspaces
            "Mod+J".action.focus-workspace-down = [ ];
            "Mod+K".action.focus-workspace-up = [ ];
            "Shift+Mod+J".action.move-window-to-workspace-down = [ ];
            "Shift+Mod+K".action.move-window-to-workspace-up = [ ];
            "Mod+Return".action.toggle-overview = [ ];

            "Mod+1".action.focus-workspace = [ 1 ];
            "Mod+2".action.focus-workspace = [ 2 ];
            "Mod+3".action.focus-workspace = [ 3 ];
            "Mod+4".action.focus-workspace = [ 4 ];
            "Mod+5".action.focus-workspace = [ 5 ];
            "Mod+6".action.focus-workspace = [ 6 ];
            "Mod+7".action.focus-workspace = [ 7 ];
            "Mod+8".action.focus-workspace = [ 8 ];
            "Mod+9".action.focus-workspace = [ 9 ];

            "Mod+Shift+1".action.move-window-to-workspace = [ 1 ];
            "Mod+Shift+2".action.move-window-to-workspace = [ 2 ];
            "Mod+Shift+3".action.move-window-to-workspace = [ 3 ];
            "Mod+Shift+4".action.move-window-to-workspace = [ 4 ];
            "Mod+Shift+5".action.move-window-to-workspace = [ 5 ];
            "Mod+Shift+6".action.move-window-to-workspace = [ 6 ];
            "Mod+Shift+7".action.move-window-to-workspace = [ 7 ];
            "Mod+Shift+8".action.move-window-to-workspace = [ 8 ];
            "Mod+Shift+9".action.move-window-to-workspace = [ 9 ];

            "Ctrl+Print".action.spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];

            "Alt+R".action.spawn = [ 
              "noctalia" 
              "msg" 
              "panel-toggle" 
              "launcher" 
            ];

            "Mod+Shift+L".action.spawn = [ 
              "noctalia" 
              "msg" 
              "session" 
              "lock" 
            ];
          };

          overview = {
            backdrop-color = "#000000";
          };
        };
      };
    };

  };
}
