{ stdenv, lib, fetchzip, pkgs ? import <nixpkgs> { } }:

let version = "15.6.0";
in fetchzip {
  name = "iosevka-ss07-bin-${version}";

  url =
    "https://github.com/be5invis/Iosevka/releases/download/v${version}/ttf-iosevka-ss07-${version}.zip";

  stripRoot = false;

  postFetch = ''
    mkdir -p $out/share/fonts/truetype
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/truetype/Iosevka
    ${pkgs.rename}/bin/rename 'iosevka-ss07-' 'Iosevka ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'extended' 'Extended ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'medium' 'Medium ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'italic' 'Italic ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'oblique' 'Oblique ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'thin' 'Thin ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'heavy' 'Heavy ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename ' bold' ' Bold ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename ' light' ' Light' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'semibold' 'Semibold ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename 'extralight' 'Extralight ' $out/share/fonts/truetype/Iosevka/*.ttf
    ${pkgs.rename}/bin/rename ' .ttf' '.ttf' $out/share/fonts/truetype/Iosevka/*.ttf
  '';

  sha256 = "04799fcgcp37dbbpkwwclx7ik2rjqziasrqmi2inypbjqgwr2h9d";

  meta = with lib; {
    homepage = "https://be5invis.github.io/Iosevka/";
    downloadPage = "https://github.com/be5invis/Iosevka/releases";
    description = ''
      Slender monospace sans-serif and slab-serif typeface inspired by Pragmata
      Pro, M+ and PF DIN Mono, designed to be the ideal font for programming.
    '';
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = [ maintainers.seylerius ];
  };
}
