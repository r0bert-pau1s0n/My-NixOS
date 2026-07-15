{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    
    # Автоматически удалять старые образы и контейнеры раз в неделю
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Устанавливаем docker-compose как системный пакет
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
