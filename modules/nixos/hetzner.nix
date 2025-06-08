{
   config,
   lib,
   pkgs,
   ...
}:
let
  inherit lib;
  inherit (lib) types mkEnableOption mkIf mkOption;
  cfg = config.platforms.hetzner;
in {
  options.platforms.hetzner = {
    enable = mkEnableOption "hetzner";

    ipv6.enable = mkEnableOption "IPv6";
    ipv6.subnet = mkOption {
      type = types.str;
      description = ''
        IPv6 subnet (usually a /64). Written as an IPv6 address,
        including the subnet mask.
      '';
    };
  };
  
  config = let 
    # Some default differences between amd64 and arm64 on Hetzner
    interface = if pkgs.system == "x86_64-linux" then "ens3"
                                                 else "enp1s0";
    subaddr   = if pkgs.system == "x86_64-linux" then "1"
                                                 else "2";

    mkAddress = {subnet, last_octet}: let
      # this is totally fake
      # but not sure if nix has real ipv6 handling provisions
      start = builtins.elemAt (builtins.match "^(.*:)[^:]*" subnet) 0;
    in
      "${start}${last_octet}"
    ;
    address = mkAddress { inherit (cfg.ipv6) subnet; last_octet = subaddr; };
    prefixLength = let
      as_str = builtins.elemAt (builtins.match "^.*/(.*)$" cfg.ipv6.subnet) 0;
    in lib.strings.toInt as_str;
  in mkIf cfg.enable {
    networking.defaultGateway6 = mkIf cfg.ipv6.enable {
      address = "fe80::1";  # Default for Hetzner
      inherit interface;
    };
    
    networking.interfaces."${interface}" = {
      useDHCP = true;
      ipv6.addresses = mkIf cfg.ipv6.enable [
        {
          inherit address prefixLength;
        }
      ];
    };
  };
}
