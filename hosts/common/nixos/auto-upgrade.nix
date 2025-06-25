{
  system.autoUpgrade = {
    enable = true;
    flake = "github:tuckershea/constellation";
    operation = "boot";
    dates = "03:00";
    randomizedDelaySec = "45min";
    allowReboot = true;
    rebootWindow = {
      lower = "02:00";
      upper = "05:00";
    };
  };
}
