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
      main = {
        font = "NotoMono Nerd Font:size=15";
        terminal = "kitty"; # {cmd} will be implicitly appended
        anchor = "center";
        lines = 5;
      };
      colors = {
        # RGBA [ RR GG BB AA ]
        background = "0a0a1ed9";
      };
      border = {
        width = 3;
      };
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
