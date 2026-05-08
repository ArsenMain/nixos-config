{ pkgs, ... }:

{
  # Bootloader.
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
      timeoutStyle = "hidden";
    };
  };

  nix = {
    # Enable flakes
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Storage optimisation
    optimise.automatic = true;
  };

  nixpkgs.config = {
    # 25.11
    /*
      permittedInsecurePackages = [
        "ciscoPacketTracer8-8.2.2"
      ];
    */
    # unstable
    permittedInsecurePackages = [ "cisco-packet-tracer-8.2.2" ];
    allowUnfree = true;
  };

  networking = {
    hostName = "stina"; # Define your hostname
    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
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

  };

  # Services
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lily = {
    isNormalUser = true;
    description = "lily";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # For packages see pkgs.nix
  };

  # Fonts
  fonts.packages = with pkgs; [ nerd-fonts.noto ];

  # home-manager
  home-manager.backupFileExtension = "hmb";

  #programs.niri.enable = true;
  #programs.niri.package = pkgs.niri;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
