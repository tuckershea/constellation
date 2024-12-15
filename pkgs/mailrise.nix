{
  pkgs,
  ...
}:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "mailrise";
  version = "1.4.0";

  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-BKl5g4R9L5IrygMd9Vbi20iF2APpxSSfKxU25naPGTc=";
  };

  dependencies = with pkgs.python3Packages; [
    apprise
    aiosmtpd
    PyYAML
  ];


  pythonImportsCheck = [ "mailrise" ];
}
