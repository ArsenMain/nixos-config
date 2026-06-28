_: {
  home-manager.users.lily.programs.fuzzel = {
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
}
