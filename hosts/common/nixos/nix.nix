{ ... }:
{
  nix.optimise.dates = [ "Mon *-*-* 04:15:00" ];
  nix.gc.dates = "Mon *-*-* 03:15:00";
}
