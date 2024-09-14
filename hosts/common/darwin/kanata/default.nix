{ outputs, pkgs, ... }:
{
  imports = [
    outputs.darwinModules.kanata
  ];

  services.kanata.enable = true;
  services.kanata.config = builtins.readFile ./kanata.kbd;
}
