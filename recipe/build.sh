#!/bin/bash

set -e
set -x

export BOOST_ROOT=$PREFIX
if [ "$(uname)" == "Darwin" ]; then
  # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
meson setup --prefix=$PREFIX --bindir=$PREFIX/bin --libdir=$PREFIX/lib --includedir=$PREFIX/include \
    --buildtype=release build_preproc \
    -Dcpp_args="-w  -Wno-enum-constexpr-conversion  -_LIBCPP_DISABLE_AVAILABILITY"  \
    -Dcpp_link_args="-w  -Wno-enum-constexpr-conversion" \
    -Dbuild_library="enabled"

else
meson setup --prefix=$PREFIX --bindir=$PREFIX/bin --libdir=$PREFIX/lib --includedir=$PREFIX/include \
    --buildtype=release build_preproc \
    -Dcpp_args="-w  -Wno-enum-constexpr-conversion"  \
    -Dcpp_link_args="-w  -Wno-enum-constexpr-conversion" \
    -Dbuild_library="enabled"
fi


meson compile -C build_preproc
meson install -C build_preproc #--destdir="../

rm $PREFIX/bin/python
