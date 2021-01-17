{ lib, pkgs, python3Packages }:

with python3Packages;

buildPythonApplication rec {
  pname = "keeprofi";
  version = "1.1.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1bcczf45cmxkr5b8wva59zn0ppc3wry8n9fbg9y179wkr85v1g48";
  };

  doCheck = false;
  #checkInputs = [ pytest ];

  propagatedBuildInputs = [
    pyxdg
    pyyaml
    xerox
    pynput
    pykeepass
    keyring
    desktop-notify
    pkgs.rofi
    pkgs.xclip
    pkgs.xdotool
  ];

  meta = with lib; {
    homepage = "https://github.com/M3NIX/rofi-keepass";
    description = "A rofi frontend to quickly access your keepass file";
    license = licenses.mit;
  };
}
