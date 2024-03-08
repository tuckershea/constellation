{ inputs, lib, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;

      # Maybe make this darwin-specific?
      extra-platforms = ["x86_64-darwin" "aarch64-darwin" ];
    };
    
    # set up gc later
  };

  services.nix-daemon.enable = true;
}
