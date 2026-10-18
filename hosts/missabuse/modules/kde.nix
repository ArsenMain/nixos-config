{
  # Enable Plasma 
  services = {
    desktopManager.plasma6.enable = true;

    # Default display manager for Plasma
    displayManager.plasma-login-manager.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];
}
