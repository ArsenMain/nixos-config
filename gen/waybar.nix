{ lib, ... }:
{
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
            position = "top";
            layer = "top";
            height = 35;

            modules-left = [ "network" ];
            modules-center = [ "clock" ];
            modules-right = [
              "pulseaudio/slider"
              "pulseaudio"
              "battery"
            ];

            clock = {
              format-alt = "{:%d. %b}";
            };

            network = {
              format-wifi = " ";
              format-ethernet = "󰈀 ";
              format-disconnected = " ";
            };
            battery = {
              format = "{capacity}%";
              format-charging = " {capacity}%";
              format-full = "  {capacity}%";
            };
            "pulseaudio/slider" = {
              "format" = "{volume}%";
              "format-muted" = " MUTE";
              "step" = 5;
              "tooltip" = false;
            };
            pulseaudio = {
              "format" = "{volume}% {icon}";
              "format-muted" = " {format_source}";
              "format-icons" = {
                "default" = [
                  ""
                  ""
                ];
              };
            };
          };
        };
        style = ./waybar.css;
      };
    };
  };
}
