{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      dracula-nvim
      # get some plugins
    ];
    viAlias = true;
    vimAlias = true;
  };
}
