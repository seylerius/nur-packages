{ lib, pkgs, python3Packages }:

with python3Packages;

buildPythonPackage rec {
  pname = "xerox";
  version = "0.4.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "09a3n68c91d9vdpqa0akkakxn6fxxczrivww5vq78wq1pba8wn8v";
  };

  doCheck = false;

  meta = with lib; {
    homepage = "http://github.com/kennethreitz/xerox";
    description = "Simple Copy + Paste in Python.";
    license = licenses.mit;
  };
}
