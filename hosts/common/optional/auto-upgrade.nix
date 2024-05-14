{
  system.autoUpgrade = {
    enable = true;
    flake = "github:NoRePercussions/nix-config";
    dates = "04:00";
    randomizedDelaySec = "45min";
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    }
  };
}

