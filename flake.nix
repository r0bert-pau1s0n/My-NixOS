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

    # Millennium — официальный моддинг-фреймворк для тем/плагинов Steam.
    # Нужен для интеграции Steam template Noctalia (Material Theme + Matugen).
    # inputs.nixpkgs.follows НЕ задаём: у флейка свой bun/nixpkgs (см. их flake.nix).
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    };

    # Home Manager — ветка master для совместимости с unstable
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      inherit (nixpkgs) lib;
      pkgs = nixpkgs.legacyPackages.${system};

      # Общий конструктор системы. Всё, что зависит от машины,
      # живёт в ./hosts/<host>/ (см. README.md).
      mkHost =
        host:
        lib.nixosSystem {
          specialArgs = { inherit inputs host; };
          modules = [ ./hosts/${host}/default.nix ];
        };
    in
    {
      nixosConfigurations = {
        nixos = mkHost "nixos";
      };

      # `nix fmt`
      formatter.${system} = pkgs.nixfmt;

      # `nix develop`
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixfmt
          deadnix
          statix
        ];
      };

      # `nix flake check` реально собирает систему
      checks.${system}.nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;
    };
}
