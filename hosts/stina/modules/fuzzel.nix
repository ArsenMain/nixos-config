{
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
        background = "000000d9";
        selection = "0a001fd9";
        border = "0a001fd9";
        text = "ffffffff";
        prompt = "ffffffff";
        input = "ffffffff";
        match = "2d008a";
        selection-match = "2d008a";
      };
      border = {
        width = 3;
      };
    };
  };
}
