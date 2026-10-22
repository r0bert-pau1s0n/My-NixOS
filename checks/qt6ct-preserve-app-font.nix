{ pkgs }:
let
  qt6ct = import ../modules/qt6ct-patched.nix { inherit pkgs; };
  fontsConf = pkgs.makeFontsConf { fontDirectories = [ ]; };
in
pkgs.stdenv.mkDerivation {
  pname = "qt6ct-preserve-app-font-test";
  version = "1";

  dontUnpack = true;
  dontConfigure = true;
  dontWrapQtApps = true;

  nativeBuildInputs = [
    pkgs.cmake
    pkgs.ninja
    pkgs.qt6Packages.qtbase
  ];

  buildInputs = [
    pkgs.qt6Packages.qtbase
  ];

  buildPhase = ''
    cat > main.cpp <<'EOF'
    #include <QApplication>
    #include <QDebug>
    #include <QFont>
    #include <QTimer>

    #include <cstdlib>

    int main(int argc, char **argv)
    {
        QApplication app(argc, argv);
        const int expectedPointSize = argc > 1 ? std::atoi(argv[1]) : 17;

        QFont font = QApplication::font();
        font.setPointSize(17);
        QApplication::setFont(font);

        QTimer::singleShot(100, &app, [&app, expectedPointSize] {
            const QFont current = QApplication::font();
            qInfo() << "application font:" << current.family() << current.pointSize();
            if (current.pointSize() != expectedPointSize) {
                qCritical() << "expected point size" << expectedPointSize
                            << "but got" << current.pointSize();
                app.exit(1);
                return;
            }
            app.exit(0);
        });

        return app.exec();
    }
    EOF

    cat > CMakeLists.txt <<'EOF'
    cmake_minimum_required(VERSION 3.20)
    project(qt6ct-preserve-app-font-test LANGUAGES CXX)
    find_package(Qt6 REQUIRED COMPONENTS Widgets)
    add_executable(test main.cpp)
    target_link_libraries(test PRIVATE Qt6::Widgets)
    EOF

    qt-cmake . -B build -G Ninja
    cmake --build build
  '';

  doCheck = true;
  checkPhase = ''
    export XDG_CONFIG_HOME="$TMPDIR/qt6ct-config"
    export XDG_CACHE_HOME="$TMPDIR/cache"
    mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME"

    FONTCONFIG_FILE=${fontsConf} \
    QT_QPA_PLATFORM=offscreen \
    QT_QPA_PLATFORMTHEME=qt6ct \
    QT_PLUGIN_PATH=${qt6ct}/lib/qt-6/plugins \
      ./build/test 17

    mkdir -p "$XDG_CONFIG_HOME/qt6ct"
    cat > "$XDG_CONFIG_HOME/qt6ct/qt6ct.conf" <<'EOF'
    [Fonts]
    general=DejaVu Sans,12
    EOF

    FONTCONFIG_FILE=${fontsConf} \
    QT_QPA_PLATFORM=offscreen \
    QT_QPA_PLATFORMTHEME=qt6ct \
    QT_PLUGIN_PATH=${qt6ct}/lib/qt-6/plugins \
      ./build/test 12
  '';

  installPhase = ''
    mkdir -p $out
  '';
}
