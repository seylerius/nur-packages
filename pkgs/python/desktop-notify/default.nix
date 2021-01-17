{ lib, pkgs, python3Packages }:

with python3Packages;

buildPythonPackage rec {
  pname = "desktop-notify";
  version = "1.3.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0xw0y0mwfh2m71lh7h4nqccay518yddf9zzm7ad2ya9gyz8lm4v2";
  };

  doCheck = false;

  propagatedBuildInputs = [ dbus-next ];

  meta = with lib; {
    homepage = "https://gitlab.com/hxss-linux/desktop-notify";
    description = "Util for sending desktop notifications over dbus.";
    license = licenses.mit;
  };
}
