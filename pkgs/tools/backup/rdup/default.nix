{ lib, stdenv, fetchFromGitHub, pkg-config, autoreconfHook, glib, pcre }:

stdenv.mkDerivation {
  pname = "rdup";
  version = "1.1.16";

  src = fetchFromGitHub {
    owner = "miekg";
    repo = "rdup";
    rev = "07e884e12957a77ab0184704d3cc2106aec2a538";
    sha256 = "0z26lmmlh25mmamcdhbp38y3c0mz3hdsg9ni3lhdrnjqc9d6hqrf";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ glib pcre ];

  meta = {
    description = "The only backup program that doesn't make backups";
    homepage = "https://github.com/miekg/rdup";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ sternenseemann ];
  };
}
