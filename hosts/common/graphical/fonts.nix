{pkgs, lib, ...}: {
  fonts.fontDir.enable = lib.mkIf pkgs.stdenv.isLinux true;
  fonts.packages = with pkgs; [
    recursive
    nerd-fonts.jetbrains-mono
  ];
}
