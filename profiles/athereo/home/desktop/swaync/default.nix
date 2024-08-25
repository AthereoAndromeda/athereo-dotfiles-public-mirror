{pkgs, ...}: let
  build-scss = path:
    pkgs.stdenv.mkDerivation {
      name = "sass-builder";
      src = path;

      nativeBuildInputs = with pkgs; [
        dart-sass
        # python312
      ];

      dontUnpack = true;
      dontPatch = true;
      dontConfigure = true;
      dontInstall = true;

      # mkdir build

      # cd $src
      # python filter.py
      # cd ..
      # echo '${base16-text}' > build/_base16.scss;

      # ls build
      # sass build/:$out/dist
      buildPhase = ''
        mkdir -p $out

        echo "Building SCSS..."
        sass $src:$out/dist
      '';
    };
in {
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile = {
    "swaync/config.json".source = ./config/config.json;
    "swaync/dist".source = "${build-scss ./config/styles}/dist";
  };
}
