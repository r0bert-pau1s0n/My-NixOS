{ ... }:

{
  # Звук — PipeWire
  # https://nixos.wiki/wiki/PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Управление питанием (для Noctalia)
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Синхронизация времени
  services.chrony.enable = true;

  # Слой совместимости для запуска бинарников
  programs.nix-ld.enable = true;
}
