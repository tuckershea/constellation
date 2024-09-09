{
  nix.settings.extra-platforms = ["x86_64-darwin" "aarch64-darwin"];
  services.nix-daemon.enable = true;

  nix.gc.interval = [{
    Hour = 3;
    Minute = 15;
    Weekday = 1;
  }];
}
