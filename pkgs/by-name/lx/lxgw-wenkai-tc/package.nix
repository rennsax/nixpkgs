{
  stdenvNoCC,
  fetchurl,
  lib,
}:

stdenvNoCC.mkDerivation rec {
  pname = "lxgw-wenkai-tc";
  version = "1.511";
  src = fetchurl {
    url = "https://github.com/lxgw/LxgwWenKaiTC/releases/download/v${version}/lxgw-wenkai-tc-v${version}.tar.gz";
    hash = "sha256-2XeON6wzV8OuFsFKRGKpsOJUxQAsQsFoRu+vDyWoMkI=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    mv *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/lxgw/LxgwWenKaiTC";
    description = "Traditional Chinese Edition of LXGW WenKai";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ lebensterben ];
  };
}
