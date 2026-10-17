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
    # pkgs.portproton (launcher Wine/Proton).
    # ВАЖНО: flake-utils вложил оверлеи по системе (overlays.<system>.default).
    # Система единая (см. flake.nix: `system = "x86_64-linux"`); ссылаться на
    # final.system/prev.system здесь нельзя — получится infinite recursion.
    inputs.portproton.overlays.x86_64-linux.default
    # PortProton GUI — это yad_gui_pp (GTK3), а в FHS steam-run GTK3 нет,
    # поэтому GUI не запускается. Подставляем steam-run, собранный с gtk3.
    (final: prev: {
      portproton = prev.portproton.override {
        steam-run = (prev.steam.override { extraPkgs = p: [ p.gtk3 ]; }).run;
      };
    })
  ];
}
