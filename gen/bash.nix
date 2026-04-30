{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      open = "xdg-open";
    };
  };
}
