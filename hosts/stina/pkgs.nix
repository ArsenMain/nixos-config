{ pkgs, ... }:
{
  users.users.lily.packages = with pkgs; [
    discord
    nixfmt
    (ciscoPacketTracer8.override {
      packetTracerSource = builtins.fetchurl {
        url = "https://www.netacad.com/authoring-resources/courses/ff9e491c-49be-4734-803e-a79e6e83dab1/c3636211-1ce6-4f92-8a22-ccddf902dd72/en-US/assets/PacketTracer822_amd64_signed_en-US_35234a27-3127-49bc-91ce-2926af76f07a.deb";
        sha256 = "0bgplyi50m0dp1gfjgsgbh4dx2f01x44gp3gifnjqbgr3n4vilkc";
      };
    })
    pgadmin4-desktopmode
    dbeaver-bin
    dotnetCorePackages.sdk_9_0_1xx
    pass
    mysql-workbench
    gimp2
    libreoffice-qt
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pavucontrol
    git
    wget
    xclip
    neovim
    nautilus
    nodejs
    unixtools.netstat
    unzip
    zip
    libgcc
  ];
  # Dotnet (look at systemPkgs)
  programs.nix-ld.enable = true;
}
