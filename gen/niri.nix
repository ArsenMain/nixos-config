{ pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    swaybg
    bibata-cursors
  ];
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

  home-manager.users.lily = {

    # XDG portal integration
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-termfilechooser ];
        config = {
          common = {
            default = [ "*" ];
            "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
          };
        };
        xdgOpenUsePortal = true;
      };
      configFile."xdg-desktop-portal-termfilechooser/config" = {
        text = ''
          [filechooser]
          cmd=$HOME/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        '';
      };
    };
    programs = {
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
              width = 1;
            };
            focus-ring = {
              enable = true;
              width = 1;
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
            "Shift+Mod+J".action.move-workspace-down = [ ];
            "Shift+Mod+K".action.move-workspace-up = [ ];
            "Mod+Return".action.toggle-overview = [ ];

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
          };
        };
      };
    };

  };
}
