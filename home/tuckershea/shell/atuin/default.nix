{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.atuin;
  flagsStr = lib.escapeShellArgs cfg.flags;
in
{
  programs.atuin = {
    enable = true;

    daemon.enable = true;

    flags = [
      "--disable-up-arrow"
    ];

    settings = {
      key_path = config.sops.secrets.atuin_key.path;
      session_path = config.sops.secrets.atuin_session.path;

      update_check = false;
      sync_frequency = "5m";
      workspace = true;
      enter_accept = true;
      keymap_mode = "vim-insert";
    };
  };

  # compatibility with zsh-vi-mode
  programs.zsh.initContent = ''
    zvm_after_init_commands+=('eval "$(${cfg.package}/bin/atuin init zsh ${flagsStr})"')
  '';

  sops.secrets.atuin_key = {
    sopsFile = ./atuin_key.+tuckershea.enc;
    format = "binary";
  };

  # WARNING: the session file cannot have a newline at the end!
  # Most conventional editors will attempt to add one, and some
  # will not even show that they added one.
  sops.secrets.atuin_session = {
    sopsFile = ./atuin_session.+tuckershea.enc;
    format = "binary";
  };
}

