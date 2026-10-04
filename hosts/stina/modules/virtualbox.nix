{
  virtualisation.virtualbox = {
    host = {
      enable = true;
    };
    guest = {
      # enabling it makes rebuilds slow, because sysinit-reactivation.target
      # is waiting for dev-vboxguest.device to start -> it neverdoes
      # see: https://github.com/NixOS/nixpkgs/issues/313696
      # enable = true;
    };
  };
}
