{ lib, ... }: {
  home-manager.users.lily = {
    # Scuffed fix to have waybar service start correctly
    systemd.user.services.waybar.Unit.ConditionEnvironment = lib.mkForce "";
    programs = {
      # waybar
      waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            "layer" = "top";
            "position" = "top";
            "modules-left" = [
              "cpu"
              "memory"
              "network"
            ];

            "modules-center" = [ "clock" ];

            "modules-right" = [
              "pulseaudio"
              "battery"
              "tray"
              "custom/lock"
              "custom/power"
            ];

            "hyprland/workspaces" = {
              "format" = "{name}: {icon}";
              "format-icons" = {
                "active" = "";
                "default" = "";
              };
            };

            "tray" = {
              "icon-size" = 16;
              "spacing" = 10;
            };

            "clock" = {
              "timezone" = "Europe/Vienna";
              "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              "format" = "{:%d/%m/%Y - %H:%M:%S}";
              "interval" = 1;
            };

            "network" = {
              "format-wifi" = "󰤢 {bandwidthDownBits}";
              "format-ethernet" = "󰈀 {bandwidthDownBits}";
              "format-disconnected" = "󰤠 No Network";
              "interval" = 5;
              "tooltip" = false;
            };

            "cpu" = {
              "interval" = 1;
              "format" = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
              "format-icons" = [
                "▁"
                "▂"
                "▃"
                "▄"
                "▅"
                "▆"
                "▇"
                "█"
              ];
            };

            "memory" = {
              "interval" = 30;
              "format" = "  {used:0.1f}G/{total:0.1f}G";
            };

            "pulseaudio" = {
              "format" = "{icon} {volume}%";
              "format-muted" = "";
              "format-icons" = {
                "default" = [
                  ""
                  ""
                  " "
                ];
              };
            };

            "custom/power" = {
              "tooltip" = false;
              "on-click" = "wlogout &";
              "format" = "⏻";
            };
          };
        };
        style = ./waybar.css;
      };
    };
  };
}
