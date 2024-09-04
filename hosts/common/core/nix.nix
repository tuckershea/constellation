{
  inputs,
  lib,
  pkgs,
  options,
  ...
}:
lib.mkMerge [
  {
    nix = {
      settings = {
        #        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;

        # Maybe make this darwin-specific?
        extra-platforms = ["x86_64-darwin" "aarch64-darwin"];

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
