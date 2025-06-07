{ config, lib, pkgs, ... }:
let
  cfg = config.programs.aerospace;

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
  programs.aerospace = {
    enable = true;
    userSettings = (builtins.fromTOML (builtins.readFile ./aerospace.toml));
  };
}
