{ pkgs, ... }: {
  environment.systemPackages =
    with pkgs;
    [ wl-clipboard ]
    ++ (with pkgs.yaziPlugins; [
      wl-clipboard
    ]);

  home-manager.users.lily.programs.yazi = {
    enable = true;
    keymap = {
      mgr.prepend_keymap = [
        { on = "<S-y>"; run = ["plugin wl-clipboard"]; }
      ];
    };
    settings = {
      mgr = {
        show_hidden = true;
      };
      opener = {
        open = [
          { run = "xdg-open %s1"; desc = "Open"; }
        ]; 
      };
    };
    plugins = { inherit (pkgs.yaziPlugins) wl-clipboard; };
    flavors = {
      gruvbox-dark = ../resources/gruvbox-dark.yazi;
    };
    theme = {
      flavor = {
        dark = "gruvbox-dark";
      };
    };
  };
}
