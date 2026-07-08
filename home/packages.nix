# ~/nix/home/packages.nix
{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [

    # Мессенджеры и браузеры
    telegram-desktop
    librewolf
    
    # Noctalia Shell (берем пакет из flake-инпута)
    inputs.noctalia.packages.${pkgs.system}.default
    
    # Прочее
    v2rayn
    xray
    sing-box
  ];
  xdg.dataFile."v2rayN/bin/xray/xray".source = "${pkgs.xray}/bin/xray";
  xdg.dataFile."v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
}
