{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    nerd-fonts.noto
    # for impact lol
    corefonts
    open-sans
  ];
}
