{ pkgs }:

rec {
  heartformer = pkgs.callPackage ./gui/writing/heartformer { };
  # qtwebflix = pkgs.callPackage ./gui/media/qtwebflix { };
  # iosevkaSS07 = pkgs.callPackage ./tools/fonts/iosevka-ss07-bin { };
  st = pkgs.callPackage ./gui/terminal-emulators/st { };
}
