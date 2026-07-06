# ~/nix/hosts/nixos/configuration.nix
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Perm";

  # Bluetooth
  hardware.bluetooth.enable = true;

  # === Графика и NVIDIA (Специфика для GTX 1660 Ti) ===
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.allowUnfree = true;
  
  hardware.nvidia = {
    modesetting.enable = true; # Обязательно для Wayland
    open = false; # 1660 Ti (Turing) требует проприетарные драйверы, NVK/open пока не для неё
    package = config.boot.kernelPackages.nvidiaPackages.production;
    powerManagement.enable = false; # Для десктопов. Если ноутбук - лучше true
  };

  # === Настройки для работы Niri и Wayland ===
  # Системная часть Niri (порталы и базовое окружение)
  programs.niri.enable = true;
  
  # Переменные окружения для Wayland/NVIDIA
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # Фикс курсора в Wayland на NVIDIA
    NIXOS_OZONE_WL = "1"; # Заставляет Electron-приложения (Discord, VSCode) работать в Wayland
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome # Нужен для скриншотов и обмена буфером в Niri
    ];
  };

  security.polkit.enable = true;
  programs.dconf.enable = true;

  # Звук
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Слой совместимости
  programs.nix-ld.enable = true;
  
  # User
  users.users.robert = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "video" ]; # Добавлена группа video для NVIDIA
    packages = with pkgs; [ tree ];
  };

  # === Настройки для корректной работы Noctalia ===
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  services.chrony.enable = true;
  
  system.stateVersion = "26.05";
}
