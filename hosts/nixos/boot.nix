{ ... }:

{
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      gfxmodeEfi = "1920x1080";
    };
    efi.canTouchEfiVariables = true;
  };
}
