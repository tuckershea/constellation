{
  inputs,
  lib,
  pkgs,
  options,
  ...
}:
{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;

      trusted-public-keys = [
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "tuckershea.cachix.org-1:a9DdtLF8DyqAHFV7VHlA7YvasP6wUMHdOygVyks3JGM="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      substituters = [
        "https://cache.nixos.org/"
        "https://tuckershea.cachix.org"
        "https://cache.garnix.io"
      ];
    };

    optimise.automatic = true;
    # optimise every Monday morning
    # customized in hosts/common/darwin/nix.nix
    # and hosts/common/nixos/nix.nix


    gc = {
      automatic = true;

      # GC every Monday morning
      # customized in hosts/common/darwin/nix.nix
      # and hosts/common/nixos/nix.nix

      # keep profile generations around for one week
      options = "--delete-older-than 7d";
    };

    registry = {
      # Lock nixpkgs so we don't need to download it
      # every time we want to do nix run/develop/etc
      nixpkgs = {
        from = { id = "nixpkgs"; type = "indirect"; };
        flake = inputs.nixpkgs;
      };
      nur = {
        from = { id = "nur"; type = "indirect"; };
        flake = inputs.nur;
      };
      ts.to = {
        type = "github";
        owner = "tuckershea";
        repo = "nur-packages";
      };
    };

    # Since we are using flakes for most everything,
    # remove channels to prevent heaps of warnings
    # on systems without initialized channels
    channel.enable = false;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
