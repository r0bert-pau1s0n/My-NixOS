{
  inputs,
  host,
  lib,
  ...
}:

{
  imports = [
    # Общие (host-agnostic) системные модули
    ../../modules/common.nix
    ../../modules/networking.nix
    ../../modules/desktop.nix
    ../../modules/services.nix
    ../../modules/docker.nix
    ../../modules/ssh.nix
    ../../modules/fonts.nix
    ../../modules/packages.nix
    ../../modules/users.nix

    # Специфика этой машины
    ./host.nix
    ./boot.nix
    ./nvidia.nix
    ./hardware-configuration.nix

    # Модули сторонних flake-ов
    inputs.niri-flake.nixosModules.niri
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Home Manager как модуль NixOS (режим сохранён).
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs host; };
    users.robert = import ../../home/default.nix;
  };
}
