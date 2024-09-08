{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./git.nix
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./zsh.nix
  ];
}
