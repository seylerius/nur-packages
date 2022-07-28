{ config, lib, pkgs, stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation {
  pname = "qtwebflix";
  version = "0.1-20220626";

  src = fetchFromGitHub {
    owner = "gort818";
    repo = "qtwebflix";
    rev = "54c2c1bfe36fbd9406d342e34dca24285440164e";
    sha256 = "1ygzdidbri5zkdygj1ni7bbac7hifl0cjksny2wil6q4p55p89in";
  };

  dontWrapQtApps = true;

  nativeBuildInputs = [
    pkgs.libsForQt5.qmake # pkgs.libsForQt5.qt5.wrapQtAppsHook
  ];

  buildInputs = [
    pkgs.libsForQt5.qt5.qtwebengine
    pkgs.libsForQt5.qt5.qtbase
    pkgs.xdg-utils
  ];

  configureScript = "qmake -config release";
}
