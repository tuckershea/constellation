{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.alacritty-theme}/dracula.toml"
      ];

      # Allow for truecolor
      # https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
      env.TERM = "xterm-256color";

      window.startup_mode = "Fullscreen";
      font.normal.family = "JetBrainsMono Nerd Font Mono";

      keyboard.bindings = [
        # Disable new tabs + windows, since I use terminal
        # next to a browser and alacritty glitches if I cmd+T it
        { key="T"; mods="Command"; action="None"; }
        { key="N"; mods="Command"; action="None"; }
      ];
    };
  };
}
