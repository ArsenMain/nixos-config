{ pkgs, ... }: {
  environment.systemPackages = with pkgs.yaziPlugins; [
    # wl-clipboard works, but clipboard throws errors... why?
    wl-clipboard
  ];
  home-manager.users.lily.programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
      };
    };
    plugins = {
      inherit (pkgs.yaziPlugins) wl-clipboard;
      #clipboardYazi = pkgs.yaziPlugins.clipboard;
    };
  };
}
