{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden --no-ignore";
    fileWidgetCommand = "fd --type f --hidden --no-ignore";
    # fileWidgetOptions = [ "--preview='head -200 {}'" ];
    changeDirWidgetCommand = "fd --type d --hidden --no-ignore";
    # changeDirWidgetOptions = [ "--preview='tree -C {} | head -200'" ];
    # tmux.enableShellIntegration = true;
  };
}
