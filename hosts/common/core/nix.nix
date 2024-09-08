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
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;

      trusted-public-keys = [
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "tuckershea.cachix.org-1:a9DdtLF8DyqAHFV7VHlA7YvasP6wUMHdOygVyks3JGM="
      ];

      substituters = [
        "https://cache.nixos.org/"
        "https://tuckershea.cachix.org"
      ];
    };

    gc = {
      automatic = true;

      # GC every Monday morning
      interval = lib.mkMerge [
        (lib.mkIf pkgs.stdenv.isDarwin [{
          Hour = 3;
          Minute = 15;
          Weekday = 1;
        }])
        (lib.mkIf pkgs.stdenv.isLinux "Mon *-*-* 03:15:00")
      ];

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
    };
  };

  services.nix-daemon.enable = lib.mkIf pkgs.stdenv.isDarwin true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
