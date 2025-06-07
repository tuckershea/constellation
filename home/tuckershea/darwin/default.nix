{ config, pkgs, ... }:
{
  imports = [
    ./aerospace
    ./defaults.nix
  ];

  home.file."Applications/Home Manager Apps".enable = false;

  home.activation = {
    home-applications = let
      env = pkgs.buildEnv {
        name = "home-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
      homedir = "/Users/tuckershea";
    in
      pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Users/tuckershea/Applications..." >&2
        rm -rf ${homedir}/Applications/Home\ Manager\ Apps
        mkdir -p ${homedir}/Applications/Home\ Manager\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          touch "${homedir}/Applications/Home Manager Apps/$app_name"
          ${pkgs.mkalias}/bin/mkalias "$src" "${homedir}/Applications/Home Manager Apps/$app_name"
        done
      '';
  };
}
