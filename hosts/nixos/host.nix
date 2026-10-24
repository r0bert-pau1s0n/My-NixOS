{ pkgs, ... }:

{
  # Сетевой идентификатор машины
  networking.hostName = "nixos";

  time.timeZone = "Asia/Yekaterinburg";

  # Первая установленная версия NixOS. НЕ менять.
  system.stateVersion = "26.05";

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "wlmouse-hidraw-udev-rules";
      destination = "/etc/udev/rules.d/72-wlmouse-hidraw.rules";
      text = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a870|a871", TAG+="uaccess"
      '';
    })
  ];
}
