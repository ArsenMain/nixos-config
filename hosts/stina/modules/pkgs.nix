{ pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
  [
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
    xdg-desktop-portal-gtk
    xdg-desktop-portal-umbriel
    # Support for X11 apps (like Discord)
    xwayland-satellite
    feh
    pulseaudio
    bitwarden-cli
    ripgrep
    hyprshot
    kdePackages.okular
    mpv
    screen
    wireshark
    slurp
    python3
    jdk
    jetbrains.idea
    rustc
    cargo
    (rstudioWrapper.override { 
      packages = with rPackages; [ tidyverse data_table rmarkdown]; 
    })
    # I actually had these as user packages, but 
    # I'm pretty sure the desktop entries I make in desktop.nix 
    # Are defined on a system level, so if I install a 
    # package on a user level, that .desktop file will take precedence
    # LOOK INTO THIS!!! Just an assumption as of right now
    nixfmt
    (pkgs.callPackage ../pkgs/pt.nix { })
    pgadmin4-desktopmode
    dbeaver-bin
    dotnetCorePackages.sdk_9_0_1xx
    # Unable to build for the moment, look into it
    # mysql-workbench
    gimp2
    libreoffice
    inkscape
  ];
  # Dotnet (look at systemPkgs)
  programs.nix-ld.enable = true;
}
