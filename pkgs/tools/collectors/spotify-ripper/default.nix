{ stdenv, fetchFromGitHub

, python3Packages

, aacSupport ? false, faac, alacSupport ? false, libav, flacSupport ? false
, flac, m4aSupport ? false, mp4Support ? false, fdk-aac-encoder
, oggSupport ? false, vorbisTools, opusSupport ? false, opusTools }:

assert aacSupport -> faac.meta.available;
assert alacSupport -> libav.meta.available;
assert flacSupport -> flac.meta.available;
assert m4aSupport || mp4Support -> fdk-aac-encoder.meta.available;
assert oggSupport -> vorbisTools.meta.available;
assert opusSupport -> opusTools.meta.available;

python3Packages.buildPythonApplication rec {
  pname = "spotify-ripper";
  version = "2016.12.31";

  src = fetchFromGitHub {
    owner = "scaronni";
    repo = pname;
    rev = "ad496e5ac5256be98bfa0985ac69e7c9d89edb15";
    sha256 = "01w6zn6aha47b99d4mhvsbklqv3l6qk1sssax2a42yk45rzxh4jz";
    # date = 2020-11-08T18:03:25+01:00;
  };

  propagatedBuildInputs = (with python3Packages; [
    colorama
    mutagen
    pyspotify
    requests
    schedule
    setuptools
  ]) ++ [
    (if flacSupport then flac else null)
    (if alacSupport then libav else null)
    (if aacSupport then faac else null)
    (if (m4aSupport || mp4Support) then fdk-aac-encoder else null)
    (if oggSupport then vorbisTools else null)
    (if opusSupport then opusTools else null)
  ];

  meta = {
    description =
      "Rip Spotify URIs to audio files, including ID3 tags and cover art";
    longDescription = ''
      Spotify-ripper is a small ripper script for Spotify that rips Spotify URIs
      to audio files and includes ID3 tags and cover art. By default
      spotify-ripper will encode to MP3 files, but includes the ability to rip
      to WAV, FLAC, Ogg Vorbis, Opus, AAC, and MP4/M4A.
    '';
    homepage = "https://github.com/hbashton/spotify-ripper";
    # spotify-ripper itself is MIT, but the upstream libspotify is unfree.
    license = stdenv.lib.licenses.unfree;
  };
}
