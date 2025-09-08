#!/bin/bash

export BOOST_ROOT=$PREFIX

meson setup --prefix=$PREFIX --bindir=$PREFIX/bin --libdir=$PREFIX/lib --includedir=$PREFIX/include \
    --buildtype=release build_preproc \
    -Dcpp_args="-nostdinc++ -nostdlib++ -w  -Wno-enum-constexpr-conversion"  \
    -Dcpp_link_args="-w  -Wno-enum-constexpr-conversion" \
    -Dbuild_library="enabled"

meson compile -C build_preproc
meson install -C build_preproc #--destdir="../

rm $PREFIX/bin/python
