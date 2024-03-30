{
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "systemd"
          "zfs"
        ];
        port = 9100;
      };
    };
  };
}
