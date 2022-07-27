{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.rdup;

  isLocalPath = x:
    builtins.substring 0 1 x == "/" # absolute path
    || builtins.substring 0 1 x == "." # relative path
    || builtins.match "[.*:.*]" == null; # not machine:path

  mkExcludeFile = cfg:
    # Write each exclude pattern to a new line
    pkgs.writeText "excludefile" (concatStringsSep "\n" cfg.exclude);

  isDefined = s: s != "" && s != null;

  # TODO: Find a solution for including a pkg if any job needs it
  anyDefined = true;

  rdup = pkgs.rdup.overrideAttrs (oldAttrs: rec {
    buildInputs = oldAttrs.buildInputs
      ++ optional (anyDefined "encryptionKeyFile") "mcrypt";
  });

  tools = {
    rdup = "${rdup}/bin/rdup";
    rdup-simple = "${rdup}/bin/rdup-simple";
    rdup-up = "${rdup}/bin/rdup-up";
    mcrypt = "${pkgs.mcrypt}/bin/mcrypt";
  };

  mkCall = tool: job:
    concatStringsSep " " [ tool ]
    ++ optional (isDefined job.destinationHost) "-c";

  rdupSimple = job:
    concatStringsSep " " [
      (mkCall tools.rdup-simple)
    ]
    # TODO: Add days of lookback
    ++ optional job.compressBackups "-z"
    ++ optional (isDefined job.encryptionKeyFile) "-k ${job.encryptionKeyFile}";

  # mkBackupScript = job:
  #   (concatStringsSep " | " (callRdup job)
  #     ++ optional job.compressBackups (callGzip job));

in {

}
