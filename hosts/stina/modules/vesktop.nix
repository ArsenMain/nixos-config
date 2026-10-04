{
  home-manager.users.lily = {
    programs.vesktop = {
      enable = true;
      settings = {
        enableSplashScreen = false;
        minimizeToTray = false;
        tray = false;
      };
      vencord = {
        settings = {
          themeLinks = [ "https://refact0r.github.io/system24/build/system24.css" ];
        };
      };
    };
  };
}
