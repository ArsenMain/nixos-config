{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [ swaybg ];
  services.displayManager.ly.enable = true;
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
      # waybar
      waybar = {
        enable = true;
        settings = {
          mainBar = {
            position = "top";
            layer = "top";
            height = 35;

            modules-center = [ "clock" ];

            "clock" = {
              format-alt = "{:%d. %b}";
            };
          };
        };
        style = ''
                * {
                        font-family: NotoMono Nerd Font;
                        font-size: 25px;
                }
          window#waybar {
                  background-color: black;
          }
          #clock {
                color: white;
          }
        '';
      };
      # niri
      niri = {
        settings = {
          spawn-at-startup = [
            { command = [ "waybar" ]; }
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
              width = 2;
            };
            focus-ring = {
              enable = true;
              width = 2;
            };
            shadow = {
              enable = true;
              spread = 5;
              softness = 30;
              offset = {
                x = 0;
                y = 5;
              };
              color = "#130166";
            };
          };
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
          binds = {
            "Alt+Q".action.spawn = [ "kitty" ];
            "Alt+Backspace".action.close-window = [ ];
            "Alt+Return".action.maximize-window-to-edges = [ ];
            "Alt+Shift+Return".action.fullscreen-window = [ ];
            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "dms"
                "ipc"
                "call"
                "audio"
                "increment"
                "3"
              ];
            };
            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn = [
                "dms"
                "ipc"
                "call"
                "audio"
                "decrement"
                "3"
              ];
            };
            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn = [
                "dms"
                "ipc"
                "call"
                "audio"
                "mute"
              ];
            };
            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action.spawn = [
                "dms"
                "ipc"
                "call"
                "audio"
                "micmute"
              ];
            };
            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [
                "dms"
                "ipc"
                "call"
                "brightness"
                "increment"
                "5"
              ];
            };
            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [
                "dms"
                "ipc"
                "call"
                "brightness"
                "decrement"
                "5"
              ];
            };
            "Mod+Left".action.focus-column-left = [ ];
            "Mod+Down".action.focus-window-down = [ ];
            "Mod+Up".action.focus-window-up = [ ];
            "Mod+Right".action.focus-column-right = [ ];

            "Mod+Shift+Left".action.move-column-left = [ ];
            "Mod+Shift+Down".action.move-window-down = [ ];
            "Mod+Shift+Up".action.move-window-up = [ ];
            "Mod+Shift+Right".action.move-column-right = [ ];

            "Alt+Shift+Left".action.set-column-width = [ "-10%" ];
            "Alt+Shift+Right".action.set-column-width = [ "+10%" ];
            "Alt+Shift+Up".action.set-window-height = [ "-10%" ];
            "Alt+Shift+Down".action.set-window-height = [ "+10%" ];

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
          };
        };
      };
    };

  };
}
