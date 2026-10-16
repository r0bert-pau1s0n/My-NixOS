{ inputs, ... }:

{
  # Nix
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Noctalia binary cache (см. docs.noctalia.dev — requires omitting nixpkgs.follows on the input)
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  # Разрешить unfree-пакеты (NVIDIA, Telegram и т.д.)
  nixpkgs.config.allowUnfree = true;

  # Оверлеи применяются один раз на системном уровне;
  # home-manager наследует их через useGlobalPkgs.
  nixpkgs.overlays = [
    # pkgs.niri-unstable
    inputs.niri-flake.overlays.niri
    # pkgs.millennium / pkgs.millennium-steam (Steam + Millennium)
    inputs.millennium.overlays.default
  ];
}
