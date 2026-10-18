{ pkgs, ... }: {
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
    # Support for X11 apps (like Discord)
    xwayland-satellite
    pulseaudio
    bitwarden-cli
    gimp2
    libreoffice-qt
    vital
    cmus
  ];
}
