{ inputs, lib, pkgs, options, ... }:
lib.mkMerge [
  {
    nix = {
      settings = {
#        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;

        # Maybe make this darwin-specific?
        extra-platforms = ["x86_64-darwin" "aarch64-darwin" ];
      };
      
      # set up gc later
    };
  }

  # nix-daemon only on darwin, check option to avoid recursion
  (lib.optionalAttrs (lib.hasAttr "nix-daemon" options.services) {
    services.nix-daemon.enable = true;
  })
]
