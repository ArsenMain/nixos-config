{ pkgs, ... }:
{
  # git
  programs.git = {
    enable = true;
    settings.user = {
      name = "ArsenMain";
      email = "doriyahganonbusted@gmail.com";
    };
  };

  # kitty
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      font-family = "NotoMono Nerd Font";
      scrollback_lines = 5000;
      remember_window_size = "no";
      initial_window_width = 800;
      initial_window_height = 400;
      linux_display_server = "wayland";
      tab_bar_style = "powerline";
      include = "~/.config/nixos-config/resources/Kaolin Ocean.conf";
      #sync_to_monitor = "yes";
      repaint_delay = 5;
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      #placeholder = "peepee";
      /*
        font = {
                name = "NotoMono Nerd Font";
                size = 20;
        };
      */
    };

  };

  programs.feedr = {
    enable = true;
    settings = {
      max_dashboard_items = 100;
      theme = "dark";
    };
  };

  programs.vesktop = {
    enable = true;
  };

  services.mako = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
