{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  name = "kanata";
  version = "v1.7.0-prerelease-1";

  src = pkgs.fetchurl {
    url = "https://github.com/jtroo/kanata/releases/download/${version}/kanata_macos_arm64";
    sha256 = "sha256-y3ZD9ygB8SSTVpL9e2MqDfkEocB+J/EYhgUEiGLr3SM=";
  };

  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/kanata
    chmod +x $out/bin/kanata
  '';
}
