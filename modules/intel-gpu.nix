{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      intel-compute-runtime
      libva-vdpau-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-vaapi-driver
    ];
  };

  environment.variables.LIBVA_DRIVER_NAME = "iHD";
}
