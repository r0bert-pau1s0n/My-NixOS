{ config, ... }:

{
  # Графика
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # NVIDIA GTX 1660 Ti (архитектура Turing)
  # https://nixos.wiki/wiki/Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;   # Обязательно для Wayland
    open = false;                # Turing требует проприетарные драйверы (NVK пока не поддерживает)
    package = config.boot.kernelPackages.nvidiaPackages.production;
    powerManagement.enable = false;  # Для десктопа; на ноутбуке — true
  };

  # Переменные окружения для Wayland/NVIDIA
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";  # Фикс курсора в Wayland на NVIDIA
    NIXOS_OZONE_WL = "1";           # Electron-приложения в Wayland
  };
}
