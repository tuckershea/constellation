{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./git.nix
    ./locale.nix
    ./nix.nix
    ./zsh.nix
  ];
}
