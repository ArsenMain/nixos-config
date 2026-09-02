{ pkgs, lib, ... }:

{
  # Environment variables
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  nix = {
    # Enable flakes
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Storage optimisation
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  nixpkgs.config = {
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

  console.keyMap = "de";

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

  services.gnome.gnome-keyring.enable = lib.mkForce false;

  # home-manager
  # for any config files that would get overriden, we modify the file with the .hmb extension
  home-manager.backupFileExtension = "hmb";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
