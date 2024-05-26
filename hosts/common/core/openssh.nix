{
  lib,
  pkgs,
  ...
}: {
  services.openssh = lib.optionalAttrs pkgs.stdenv.isLinux {
    enable = true;
    ports = [22]; # change this later?

    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };
}
