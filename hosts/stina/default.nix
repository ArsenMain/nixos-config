{ ... }:
{
  imports = [
    ./configuration.nix
    ./firefox.nix
    ./gnome.nix
    ./iris.nix
    ./pkgs.nix
    ./mysql.nix
    ./postgres.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./yazi.nix
  ];
}
