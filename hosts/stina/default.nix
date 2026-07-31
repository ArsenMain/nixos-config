{ ... }: {
  imports = [
    ./configuration.nix
    ./iris.nix
    ./pkgs.nix
    ./mysql.nix
    ./postgres.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./yazi.nix
    ./kitty.nix
    ./fuzzel.nix
    ./feedr.nix
    ./git.nix
    ./vsc.nix
    ./mako.nix
    ./vesktop.nix
  ];
}
