{
  description = "My NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Официальный flake Niri (https://github.com/sodiboo/niri-flake)
    niri-flake.url = "github:sodiboo/niri-flake";

    # Noctalia Shell
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri-flake, noctalia, ... }@inputs: 
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; 
      modules = [ 
        ./hosts/nixos/configuration.nix
        # Подключаем системный модуль Niri (настраивает xdg-portals, dbus и т.д.)
        niri-flake.nixosModules.niri
      ];
    };
    
    homeConfigurations.robert = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
      modules = [ 
        ./home/home.nix
        # Подключаем модуль Niri для Home-Manager (дает programs.niri.settings)
        niri-flake.homeModules.niri
      ];
    };
  };
}
