{ config, lib, pkgs, stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation {
  pname = "qtwebflix";
  version = "0.1-20210623";

  src = fetchFromGitHub {
    owner = "gort818";
    repo = "qtwebflix";
    rev = "5fc1e15a5afeed528b5d2ab03d5eb9d7bcbdf027";
    sha = "0r9fwa685fwsq1wcidqjdyxar3lgcl4q6qx2flq42ykmwycs7zs8";
  };

  nativeBuildInputs = [ pkgs.qmake ];

  buildInputs = [ pkgs.libsForQt5.qt5.qtwebengine xdg-utils ];

  configureScript = "qmake -config release";
}
