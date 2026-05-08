{ ... }:
{
  home-manager.users.lily.programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
      };
    };
  };
}
