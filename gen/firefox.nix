{ ... }:
{
  programs.firefox = {
    enable = true;
    policies = {
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      PromptForDownloadLocation = true;
      PasswordManagerEnabled = false;
      GenerativeAI.Enabled = false;
      FirefoxSuggest.SponsoredSuggestions = false;
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Stories = false;
        SponsoredStories = false;
      };
      SearchEngines = {
        Default = "Startpage - English";
        DefaultPrivate = "Startpage - English";
      };
      ExtensionSettings = {
        "*" = {
          installation_mode = "allowed";
        };
        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{20fc2e06-e3e4-4b2b-812b-ab431220cada}" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{20fc2e06-e3e4-4b2b-812b-ab431220cada}/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{d7742d87-e61d-4b78-b8a1-b469842139fa}/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };

      };
    };
  };
}
