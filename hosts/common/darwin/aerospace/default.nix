{ config, lib, pkgs, ... }:
let
  cfg = config.services.aerospace;

  format = pkgs.formats.toml { };
  filterAttrsRecursive = pred: set:
    lib.listToAttrs (
      lib.concatMap (
        name: let
          v = set.${name};
        in
          if pred v
          then [
            (lib.nameValuePair name (
              if lib.isAttrs v
              then filterAttrsRecursive pred v
              else if lib.isList v
              then
                (map (i:
                  if lib.isAttrs i
                  then filterAttrsRecursive pred i
                  else i) (lib.filter pred v))
              else v
            ))
          ]
          else []
      ) (lib.attrNames set)
    );
  filterNulls = filterAttrsRecursive (v: v != null);
  configFile = format.generate "aerospace.toml" (filterNulls cfg.settings);
in
{
  services.aerospace = {
    enable = true;
    settings = (builtins.fromTOML (builtins.readFile ./aerospace.toml));
  };

  launchd.user.agents.aerospace.command = 
          lib.mkForce ("taskpolicy -l 5 ${cfg.package}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"
          + (lib.optionalString (cfg.settings != { }) " --config-path ${configFile}"));
}
