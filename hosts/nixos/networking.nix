{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.resolved.enable = true;

  time.timeZone = "Asia/Yekaterinburg";

  hardware.bluetooth.enable = true;
}
