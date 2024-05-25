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
      
      gc = {
        automatic = true;
        # nixos and darwin have different ways to configure
        # this interval, so instead we just leave it to
        # the default of 3:15 daily, which is fine.
        options = "--delete-older-than 7d";
      };
    };
  }

  # nix-daemon only on darwin, check option to avoid recursion
  (lib.optionalAttrs (lib.hasAttr "nix-daemon" options.services) {
    services.nix-daemon.enable = true;
  })
]
