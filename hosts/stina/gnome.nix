{ pkgs, ... }:
{
  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "at";
        variant = "";
      };
      # excludePackages = with pkgs; [ xterm ];
      # Intel (???)
      videoDrivers = [ "modesetting" ];
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      core-developer-tools.enable = false;
      games.enable = false;
    };
  };
  # Config for gnome desktop
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          enable-hot-corners = false;
          color-scheme = "prefer-dark";
        };
        "org/gnome/desktop/wm/keybindings" = {
          maximize = [ "<Alt>Return" ];
          minimize = [ "<Alt>Down" ];
          close = [ "<Alt>BackSpace" ];
          show-desktop = [ "<Alt><Super>Down" ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Alt>q";
          command = "kitty";
          name = "Launch Kitty";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          binding = "<Alt>e";
          command = "nautilus";
          name = "Launch Nautilus";
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          screensaver = [ "<Control><Alt>l" ];
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          ];
        };
        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/lily/.config/nixos-config/resources/inland.webp";
          picture-uri-dark = "file:///home/lily/.config/nixos-config/resources/inland.webp";
        };
        "org/gnome/desktop/screen-time-limits" = {
          history-enabled = false;
          daily-limit-enabled = false;
        };
      };
    }
  ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs ];
}
