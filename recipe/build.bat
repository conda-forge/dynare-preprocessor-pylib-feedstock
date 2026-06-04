@echo on
REM Set environment variable BOOST_ROOT
set BOOST_ROOT=%PREFIX%

REM Run meson setup
meson setup ^
  --prefix=%PREFIX% ^
  --bindir=%PREFIX%\bin ^
  --libdir=%PREFIX%\lib ^
  --includedir=%PREFIX%\include ^
  --buildtype=release build_preproc ^
  -Dcpp_args="-w -Wno-enum-constexpr-conversion " ^
  -Dcpp_link_args="-w -Wno-enum-constexpr-conversion" ^
  -Dbuild_library=enabled ^
  -Dcpp_std=c++20

type $SRC_DIR/build_preproc/meson-logs/meson-log.txt

REM Compile with meson
meson compile -C build_preproc

REM Install with meson
meson install -C build_preproc

REM Remove the Python binary if it exists
if exist "%PREFIX%\bin\python.exe" del "%PREFIX%\bin\python.exe"
if exist "%PREFIX%\bin\python" del "%PREFIX%\bin\python"
