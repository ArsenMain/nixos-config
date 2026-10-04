{
  home-manager.users.lily.xdg = {
    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop"; 
        /*"application/x-pkt" = "cisco-pt8.desktop";
        "application/x-pka" = "cisco-pt8.desktop";
        "application/x-pkz" = "cisco-pt8.desktop";
        "application/x-pksz" = "cisco-pt8.desktop";
        "application/x-pks" = "cisco-pt8.desktop";*/
      };
    };
  };
}
