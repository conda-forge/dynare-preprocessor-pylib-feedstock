@echo on

set "BOOST_ROOT=%LIBRARY_PREFIX%"
set "BOOSTROOT=%LIBRARY_PREFIX%"

meson setup ^
  --prefix="%PREFIX%" ^
  --bindir="%LIBRARY_BIN%" ^
  --libdir="%LIBRARY_LIB%" ^
  --includedir="%LIBRARY_INC%" ^
  --buildtype=release build_preproc ^
  -Dcpp_args="-w -Wno-enum-constexpr-conversion -I%LIBRARY_INC%" ^
  -Dcpp_link_args="-w -Wno-enum-constexpr-conversion -L%LIBRARY_LIB%" ^
  -Dbuild_cli=disabled ^
  -Dbuild_library=enabled
if errorlevel 1 exit 1

meson compile -C build_preproc
if errorlevel 1 exit 1

meson install -C build_preproc
if errorlevel 1 exit 1
