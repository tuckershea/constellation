{ config, ... }:
{
  programs.msmtp = {
    enable = true;
    setSendmail = true;
    defaults = {
      host = "smtp.constellation.tuckershea.com";
      auto_from = "on";
      maildomain = config.networking.fqdn;
    };
    accounts.default = {};
  };
}
