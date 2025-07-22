{
  pkgs,
  ...
}:
{
  imports = [
    ./alacritty.nix
    ./surfingkeys
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    themeFile = "Dracula";
    settings = {
      shell = "${pkgs.fish}/bin/fish";
      update_check_interval = 0;
      scrollback_lines = 10000;
      enable_audio_bell = "no";
      visual_bell_duration = "0.5 ease-in-out";
      window_alert_on_bell = "no";
      remember_window_size = "no";
      remember_window_position = "no";
      placement_strategy = "bottom-left";
      resize_in_steps = "no";  # let window manager do it
      confirm_os_window_close = 0;
      macos_option_as_alt = "left";
      macos_show_window_title_in = "menubar";
      macos_menubar_title_max_length = 40;
      hide_window_decorations = "yes";
    };
  };
}
