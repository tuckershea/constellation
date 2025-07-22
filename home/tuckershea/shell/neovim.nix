{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.dracula.enable = true;

    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      showmode = false;

      colorcolumn = "70";

      cursorline = true;

      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;

      splitright = true;

      smartcase = true;
      mouse = "";
      undofile = true;
    };

    globals = {
      mapleader = " ";
    };

    plugins.leap.enable = true;
    plugins.lsp.enable = true;
    # substitute.nvim?
    plugins.treesitter.enable = true;
  };
}
