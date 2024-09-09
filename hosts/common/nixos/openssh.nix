{
  lib,
  pkgs,
  ...
}:
{
  services.openssh = {
    enable = true;
    ports = [22]; # change this later?

    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };
}
