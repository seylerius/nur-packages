{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, appimageTools ? pkgs.appimageTools, ... }:

let
  pname = "HeartFormer";
  version = "0.30.1";
  name = "${pname}-${version}";
  src = pkgs.requireFile {
    name = "${pname}-${version}.AppImage";
    url = "https://be-heartformer.itch.io/heartformer";
    sha256 = "be896879516b6de068b18e6b427adf575ee491c12db52748b4c32b6f63f26001";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };

in appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/heartformer.desktop $out/share/applications/heartformer.desktop
    # install -m 444 -d ${appimageContents}/usr/share/icons/hicolor/0x0/apps/heartformer.png \
    #   $out/share/icons/hicolor/0x0/apps/heartformer.png
    substituteInPlace $out/share/applications/heartformer.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

  meta = with lib; {
    description = "Integrated Divination Environment";
    homepage = "https://heartformer.com/";
    downloadPage = "https://be-heartformer.itch.io/heartformer";
    license = licenses.unfree;
    maintainers = with maintainers; [ seylerius ];
    platforms = [ "x86_64-linux" ];
  };
}
