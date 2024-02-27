{ pkgs, lib, ... }:
{
  # Nix Configuration
  # Inspired by https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix environment
  programs.zsh.enable = true;

  # Auto-upgrade nix daemon and packages
  services.nix-daemon.enable = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     recursive
     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Add ability to used TouchID for sudo authentication
  # doesn't seem to make sense without additional module
  security.pam.enableSudoTouchIdAuth = true;
}
