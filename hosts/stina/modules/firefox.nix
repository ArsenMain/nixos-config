{
  programs.firefox = {
    policies = {
      ExtensionSettings = {
        "myallychou@gmail.com" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/myallychou@gmail.com/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "unhook-reddit@example.com" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/myallychou@gmail.com/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };
}
