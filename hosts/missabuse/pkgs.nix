{ pkgs, ... }: {
  users.users.lily.packages = with pkgs; [
    nixfmt
    gimp2
    libreoffice-qt
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    xclip
    neovim
    nodejs
    unixtools.netstat
    unzip
    zip
    libgcc
    gnome-calculator
    xdg-desktop-portal-termfilechooser
    # Support for X11 apps (like Discord)
    xwayland-satellite
    ncdu
    brightnessctl
    feh
    pulseaudio
    bitwarden-cli
  ];
  # Dotnet (look at systemPkgs)
  programs.nix-ld.enable = true;
}
