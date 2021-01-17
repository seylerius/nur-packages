{ pkgs }:

rec {
  python3Packages = pkgs.python3Packages // {
    desktop-notify = pkgs.callPackage ./python/desktop-notify/default.nix {
      inherit python3Packages;
    };

    xerox =
      pkgs.callPackage ./python/xerox/default.nix { inherit python3Packages; };
  };

  keeprofi = pkgs.callPackage ./gui/launcher/rofi/keeprofi.nix {
    inherit python3Packages;
  };
}
