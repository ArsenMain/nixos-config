let
  entry = name: icon: exec: { inherit name; icon = ../resources/icons + icon; inherit exec; };
in
{
  home-manager.users.lily.xdg.desktopEntries = {
    firefox = entry "Firefox" "/firefox.svg" "firefox";
    vesktop = entry "Vesktop" "/vesktop.svg" "vesktop";
    htop = entry "Htop" "/htop.svg" "kitty htop";
    gimp = entry "GNU Image Manipulation Program" "/gimp.svg" "gimp";
  };
}
