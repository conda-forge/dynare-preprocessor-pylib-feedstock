#!/bin/bash

export BOOST_ROOT=$PREFIX

#!/bin/bash
#!/usr/bin/env bash

set -e
set -x

if [ "$(uname)" == "Darwin" ]; then
  # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

meson setup --prefix=$PREFIX --bindir=$PREFIX/bin --libdir=$PREFIX/lib --includedir=$PREFIX/include \
    --buildtype=release build_preproc \
    -Dcpp_args="-w  -Wno-enum-constexpr-conversion"  \
    -Dcpp_link_args="-w  -Wno-enum-constexpr-conversion" \
    -Dbuild_library="enabled"

meson compile -C build_preproc
meson install -C build_preproc #--destdir="../

rm $PREFIX/bin/python
