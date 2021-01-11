{ pkgs }:

rec {
  spotify-ripper = pkgs.callPackage ../tools/collectors/spotify-ripper {
    # NOTE: Not available in 20.03. Specifying it this way lets me cheat the
    # build auto-failing on 20.03 because of the attribute not existing.
    inherit (pkgs) fdk-aac-encoder;
    python2Packages = pkgs.python3Packages;
  };
}
