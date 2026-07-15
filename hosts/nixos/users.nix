{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.robert = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "video" "docker" ];
    packages = with pkgs; [ tree ];
    shell = pkgs.zsh;
  };
}
