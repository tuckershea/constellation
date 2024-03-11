{ sops-nix, lib, config }:
let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;

  # nix-darwin does not keep host keys in config
  # so we need to get them some other way
  hasHostKeys = hasAttr "hostKeys" config.services.openssh;
  keys = lib.optionals hasHostKeys builtins.filter isEd25519 config.services.openssh.hostKeys;
in
{
  temp
