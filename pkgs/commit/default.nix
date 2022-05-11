{ stdenv
, lib
, desktop-file-utils
, meson
, ninja
, gettext
, python3
, pkg-config
, gnome
, gtk4
, gobject-introspection
, wrapGAppsHook
, fetchFromGitHub
, gjs
, libadwaita
}:

stdenv.mkDerivation rec {
  pname = "commit";
  version = "3.2.0";

  src = fetchFromGitHub {
    owner = "sonnyp";
    repo = "Commit";
    rev = "v${version}";
    hash = "sha256-nnjHuE7MzCuoPfCb4MA00BIzLPbhgR6mbeWYagmNjME=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    meson
    ninja
    pkg-config
    python3
    wrapGAppsHook
  ];

  buildInputs = [
    gjs
    gtk4
    libadwaita
    gnome.adwaita-icon-theme
    gobject-introspection
  ];

  dontPatchShebangs = true;

  meta = with lib; {
    homepage = "https://commit.sonny.re/";
    description = "Commit message editor";
    maintainers = [ maintainers.Cogitri ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}

