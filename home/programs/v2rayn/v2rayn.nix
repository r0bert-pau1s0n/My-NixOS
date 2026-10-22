{ pkgs, ... }:

{
  # Симлинки бинарников для v2rayN
  xdg.dataFile."v2rayN/bin/xray/xray".source = "${pkgs.xray}/bin/xray";
  xdg.dataFile."v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
}
