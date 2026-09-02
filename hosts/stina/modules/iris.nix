{ pkgs, ... }: {
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };
    # May help if FFmpeg/VAAPI/QSV init fails (esp. on Arc with i915):
    enableRedistributableFirmware = true;
  };
  security.rtkit.enable = true;
  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
      # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
    };
  };
  boot.kernelParams = [ "i915.enable_guc=3" ];
}
