{ config, pkgs, lib, home-manager, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
  };

  programs.dconf.profiles.user.databases = [
        {
                lockAll = true;
                settings = {
                        "org/gnome/desktop/interface" = {
                                enable-hot-corners = false;
                                color-scheme = "prefer-dark";
                        };
                        "org/gnome/desktop/wm/keybindings" = {
                                maximize = ["<Alt>Return"];
                                minimize = ["<Alt>Down"];
                                close = ["<Alt>BackSpace"];
                                show-desktop = ["<Alt><Super>Down"];
                        };
                        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                                binding = "<Alt>q";
                                command = "kitty";
                                name = "Launch Kitty";
                        };
                        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
                                binding = "<Alt>e";
                                command = "nautilus";
                                name = "Launch Nautilus";
                        };
                        "org/gnome/settings-daemon/plugins/media-keys" = {
                                screensaver = ["<Control><Alt>l"];
                                custom-keybindings = [
                                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" 
                                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                                ];
                        };
                        "org/gnome/desktop/background" = {
                                picture-uri = "file:///etc/nixos/resources/inland.webp";
                                picture-uri-dark = "file:///etc/nixos/resources/inland.webp";
                        };
                        "org/gnome/desktop/screen-time-limits" = {
                                daily-limit-enabled = false;
                        };
                };
        }
  ];

  networking.hostName = "errol"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # GNOME and GDM
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  services.xserver.excludePackages = with pkgs; [ xterm ];
  


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "at";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lily = {
    isNormalUser = true;
    description = "lily";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Bash
  programs.bash = {
        enable = true;
        shellAliases = {
                ll = "ls -la";
        };
  };

  # Install firefox
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
                ExtensionSettings = {
                        "*" = {
                          installation_mode = "blocked";
                        };
                        "uBlock0@raymondhill.net" = {
                                default_area = "menupanel";
                                install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
                                installation_mode = "force_installed";
                                private_browsing = true;
                        };
                };
        };
  };

  programs.htop = {
        enable = true;
        settings = {
                hide_kernel_threads=1;
                hide_userland_threads=0;
                hide_running_in_container=0;
                shadow_other_users=0;
                show_thread_names=0;
                show_program_path=1;
                highlight_base_name=0;
                highlight_deleted_exe=1;
                shadow_distribution_path_prefix=0;
                highlight_megabytes=1;
                highlight_threads=1;
                highlight_changes=0;
                highlight_changes_delay_secs=5;
                find_comm_in_cmdline=1;
                strip_exe_from_cmdline=1;
                show_merged_command=0;
                header_margin=1;
                screen_tabs=1;
                detailed_cpu_time=0;
                cpu_count_from_one=0;
                show_cpu_usage=1;
                show_cpu_frequency=0;
                show_cpu_temperature=0;
                degree_fahrenheit=0;
                show_cached_memory=1;
                update_process_names=0;
                account_guest_in_cpu_meter=0;
                color_scheme=6;
                enable_mouse=1;
                delay=15;
                hide_function_bar=0;
                header_layout="two_67_33";
                column_meters_0=["AllCPUs" "Memory" "Swap"];
                column_meter_modes_0=[1 1 1];
                column_meters_1=["Clock" "Tasks" "LoadAverage"];
                column_meter_modes_1=[2 2 2];
                tree_view=1;
                sort_key=46;
                tree_sort_key=47;
                sort_direction=-1;
                tree_sort_direction=-1;
                tree_view_always_by_pid=0;
                all_branches_collapsed=1;
                screen = ["Main" "PID" "USER" "STATE" "PERCENT_CPU" "PERCENT_MEM" "TIME" "Command"];
        };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     pavucontrol
     git
     wget
     xclip
     neovim
     nautilus
     pass
     dotnetCorePackages.sdk_9_0_1xx
     nodejs
     node2nix
     mysql-workbench
     unixtools.netstat
  ];

  # Fonts
  fonts.packages = with pkgs; [
        nerd-fonts.noto
  ];

  # Dotnet (look at systemPkgs)
  programs.nix-ld.enable = true;

  # Storage optimisation
  nix.optimise.automatic = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services 
  services.mysql = {
        enable = true;
        package = pkgs.mariadb;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
