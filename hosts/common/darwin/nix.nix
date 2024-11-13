{
  nix.settings.extra-platforms = ["x86_64-darwin" "aarch64-darwin"];
  services.nix-daemon.enable = true;

  nix.optimise.interval = [{
    Hour = 4;
    Minute = 15;
    Weekday = 1;
  }];

  nix.gc.interval = [{
    Hour = 3;
    Minute = 15;
    Weekday = 1;
  }];
}
