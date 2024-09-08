{pkgs, lib, ...}: {
  fonts.fontDir.enable = lib.mkIf pkgs.stdenv.isLinux true;
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}
