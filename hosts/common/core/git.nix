# System-wide git
# Native on MacOS, so activate only on linux
{
  lib,
  pkgs,
  options,
  ...
}:
lib.mkMerge [
  # programs.git only on nixos, check option to avoid recursion
  (lib.optionalAttrs (lib.hasAttr "git" options.programs) {
    programs.git.enable = true;
  })
]
