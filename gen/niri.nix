{ pkgs, inputs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    swaybg
    bibata-cursors
  ];
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
  };

  # Authentication agent needed
  security.polkit.enable = true;

  /*
    # Set up additional programs as systemd services (waybar, swaybg, ...)
    systemd.user.services = {
    };
  */

  # For XDG portal integration
  # environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # XDG portal integration
  xdg = {
    portal = {
      enable = true;
      # Force this config to remove the gnome portal from extraPortals -> this fixes the slow startup issue with waybar and co.
      extraPortals = with pkgs; lib.mkForce [ xdg-desktop-portal-termfilechooser xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = [ "*" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        };
      };
      xdgOpenUsePortal = true;
    };
    /*configFile."xdg-desktop-portal-termfilechooser/config" = {
      text = ''
        [filechooser]
        cmd=$HOME/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      '';
    };*/
  };

  home-manager.users.lily = {
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 180;
          command = "${pkgs.hyprlock}/bin/hyprlock";
        }
      ];
    };

    programs = {
      # hyprlock
      hyprlock = {
        enable = true;
        settings = {
          general = {
            ignore_empty_input = true;
          };
          input-field = {
            outer_color = "rgb(11, 6, 28)";
            inner_color = "rgb(255, 255, 255)";
            capslock_color = "rgb(155, 155, 155)";
            fade_on_empty = false;
            dots_center = true;
            hide_input = false;
            rounding = -1;
            outline_thickness = 0;
            placeholder_text = "<i>be honest</i>";
            font_family = "NotoMono Nerd Font";
            # lol
            dots_text_format = "UwU";
          };
          background = {
            path = "screenshot";
            blur_passes = 2;
          };
        };
      };
      # niri
      niri = {
        settings = {
          spawn-at-startup = [
            {
              command = [
                "swaybg"
                "-i"
                "/home/lily/.config/nixos-config/resources/inland.webp"
              ];
            }
          ];
          gestures.hot-corners.enable = false;
          switch-events = {

          };
          input = {
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
          ];
          environment = {
            XDG_CURRENT_DESKTOP = "niri";
          };

          hotkey-overlay.skip-at-startup = true;
          prefer-no-csd = true;
          screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d %H-%M-%S.png";
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
            "Alt+Backspace".action.close-window = [ ];
            "Alt+Return".action.maximize-window-to-edges = [ ];
            "Alt+Shift+Return".action.fullscreen-window = [ ];

            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn = [
                # I think @DEFAULT_SINK@ acts as a var or identifier for wpctl, means to access the default audio input device (being called a sink)
                # wpctl is a CLI for the PipeWire session manager WirePlumber
                "wpctl"
                "set-volume"
                "@DEFAULT_SINK@"
                ".05+"
              ];
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "wpctl"
                "set-volume"
                "@DEFAULT_SINK@"
                ".05-"
              ];
            };

            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_SINK@"
                "toggle"
              ];
            };

            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action.spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_SOURCE@"
                "toggle"
              ];
            };

            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [
                "brightncessctl"
                "s"
                "+5%"
              ];
            };

            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [
                "brightncessctl"
                "s"
                "5%-"
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

            "Print".action.spawn = [
              "dms"
              "screenshot"
            ];
            "Ctrl+Print".action.spawn = [
              "dms"
              "screenshot"
              "--no-file"
            ];

            "Alt+R".action.spawn = [ "fuzzel" ];
            "Alt+E".action.spawn = [
              "kitty"
              "yazi"
            ];

            "Mod+L".action.spawn = [ "hyprlock" ];
          };

          overview = {
            backdrop-color = "#000000";
          };
        };
      };
    };

  };
}
