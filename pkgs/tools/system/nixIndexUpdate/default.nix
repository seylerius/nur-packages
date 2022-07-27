{ pkgs, ... }:

pkgs.writeScriptBin "nix-index-update" ''
  tag=$(git -c 'versionsort.suffix=-' \
    ls-remote \
    --exit-code \
    --refs \
    --tags \
    --sort='v:refname' \
    https://github.com/Mic92/nix-index-database \
    | awk 'END {match($2, /([^/]+)$/, m); print m[0]}')
  curl -L "https://github.com/Mic92/nix-index-database/releases/download/$tag/files" -o $XDG_RUNTIME_DIR/files-$tag
  mv $XDG_RUNTIME_DIR/files-$tag $HOME/.cache/nix-index/files
''
