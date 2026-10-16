{ ... }:

{
  # Включаем OpenSSH сервер
  services.openssh = {
    enable = true;

    # Меняем стандартный порт на 4444
    ports = [ 4444 ];

    # Автоматически открывает порт 4444 в файрволе NixOS
    openFirewall = true;

    settings = {
      # Запрещаем вход под root
      PermitRootLogin = "no";

      # Запрещаем вход по паролю
      PasswordAuthentication = false;

      # Разрешаем вход по SSH-ключам
      PubkeyAuthentication = true;
    };
  };
}
