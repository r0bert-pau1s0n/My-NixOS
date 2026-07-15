{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./nvidia.nix
    ./desktop.nix
    ./services.nix
    ./packages.nix
    ./users.nix
    ./fonts.nix
    ./docker.nix
  ];

  # Nix
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # Noctalia binary cache
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  # Разрешить unfree-пакеты (NVIDIA, Telegram и т.д.)
  nixpkgs.config.allowUnfree = true;

  # Оверлей Niri — даёт pkgs.niri-unstable
  # Применяется один раз на уровне системы, home-manager наследует через useGlobalPkgs
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  system.stateVersion = "26.05";
}
