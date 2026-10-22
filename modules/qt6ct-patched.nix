{ pkgs }:
pkgs.qt6Packages.qt6ct.overrideAttrs (old: {
  patches = (old.patches or [ ]) ++ [
    ./patches/qt6ct-preserve-app-font.patch
  ];
})
