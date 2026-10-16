{
  description = "My NixOS configuration";

  inputs = {
    # Нестабильная ветка для самых свежих пакетов
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Niri compositor
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell v5 — ветка cachix (последний закэшированный коммит).
    # ВАЖНО: inputs.nixpkgs.follows НЕ задаём — иначе слетает бинарный кэш.
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    # Home Manager — ветка master для совместимости с unstable
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri-flake, noctalia, ... }@inputs:
  let
    system = "x86_64-linux";

    # ─────────────────────────────────────────────────────
    # Временный overlay для исправления удалённой библиотеки
    # libdisplay-info_0_2 (удалена из nixpkgs unstable)
    #
    # TODO: Удалить после исправления в niri-flake
    # ─────────────────────────────────────────────────────
    fixLibdisplayInfo = final: prev: {
      libdisplay-info_0_2 = final.libdisplay-info;
    };

  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };

      modules = [
        # Модуль с overlay и базовыми настройками
        {
          nixpkgs.hostPlatform = system;
          nixpkgs.overlays = [ fixLibdisplayInfo ];
        }

        ./hosts/nixos/configuration.nix

        niri-flake.nixosModules.niri

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.robert = import ./home/home.nix;
        }
      ];
    };
  };
}
