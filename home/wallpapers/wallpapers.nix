{ lib, ... }:

let
  wallpaperDir = ./.;
  
  allFiles = builtins.attrNames (builtins.readDir wallpaperDir);
  
  isImage = file: 
    lib.hasSuffix ".png" file || 
    lib.hasSuffix ".jpg" file || 
    lib.hasSuffix ".jpeg" file || 
    lib.hasSuffix ".webp" file;
    
  wallpaperFiles = builtins.filter isImage allFiles;
in
{
  xdg.configFile = builtins.listToAttrs (map (file: {
    name = "wallpapers/${file}";
    value = { source = "${wallpaperDir}/${file}"; };
  }) wallpaperFiles);
}
