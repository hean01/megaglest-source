#!/bin/sh
#
# Use this script to compile using mingw compiler (experimental script)
# ----------------------------------------------------------------------------
# Originally written by Mark Vejvoda <mark_vejvoda@hotmail.com>
# Copyright (c) 2012 Mark Vejvoda under GNU GPL v3.0

NUMCORES=`lscpu -p | grep -cv '^#'`
if [ "$NUMCORES" = '' ]; then NUMCORES=1; fi

#PROJECT_SOURCE_DIR="$(dirname $(readlink -f $0))"
mkdir -p build-win32
cd build-win32

cmake -DCMAKE_TOOLCHAIN_FILE=../../mk/cmake/Modules/Toolchain-mingw32.cmake -DXERCESC_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/xerces-c-src_2_8_0/include -DXERCESC_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/xerces-c-src_2_8_0/lib -DXERCESC_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/xerces-c-src_2_8_0/lib/libxerces-c2_8_0.dll -DOPENAL_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/openal-soft-1.12.854 -DOPENAL_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/OpenAL32.dll -DOGG_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/libogg-1.2.1/include -DOGG_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libogg.dll -DVORBIS_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libvorbis.dll -DVORBIS_FILE_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libvorbisfile.dll -DLUA_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/lua-5.1/src -DLUA_LIBRARIES=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/lua5.1.dll -DJPEG_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/jpeg-8b -DJPEG_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libjpeg.dll -DZLIB_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/zlib-1.2.5 -DZLIB_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libz.a -DPNG_PNG_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/lpng141 -DPNG_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libpng.dll -DCURL_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/curl-7.21.3/include -DCURL_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libcurl.dll -DSDL_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/SDL-1.2.x/include -DFREETYPE_INCLUDE_DIR_ft2build=${PROJECT_SOURCE_DIR}/source/win32_deps/freetype-2.4.8/include -DFREETYPE_INCLUDE_DIR_freetype2=${PROJECT_SOURCE_DIR}/source/win32_deps/freetype-2.4.8/include/freetype -DFREETYPE_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libfreetype-6.dll -DFTGL_INCLUDE_DIR=${PROJECT_SOURCE_DIR}/source/win32_deps/ftgl-2.1.3~rc5/src -DFTGL_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/libftgl.a -DGLEW_INCLUDE_PATH=${PROJECT_SOURCE_DIR}/source/win32_deps/glew-1.7.0/include -DGLEW_LIBRARY=${PROJECT_SOURCE_DIR}/source/win32_deps/lib/glew32.dll -DCMAKE_INSTALL_PREFIX= -DWANT_STATIC_LIBS=ON -DHAS_SSE_EXTENSION=ON ..

make -j$NUMCORES

#echo 'You may now launch mega-glest from this folder like this:'
#echo '../mk/linux/glest.bin --ini-path=../mk/linux/ --data-path=../mk/linux/'

echo 'Copying mingw dependencies if they are missing...'

[[ -f "data/glest_game/lua51.dll" ]] && cp source/win32_deps/lib/lua5.1.dll data/glest_game/lua51.dll
[[ -f "data/glest_game/libcurl-4.dll" ]] && cp source/win32_deps/curl-7.21.3/lib/.libs/libcurl-4.dll data/glest_game/libcurl-4.dll
[[ -f "data/glest_game/libxerces-c2_8_0.dll" ]] && cp source/win32_deps/xerces-c-src_2_8_0/lib/libxerces-c2_8_0.dll data/glest_game/libxerces-c2_8_0.dll
[[ -f "data/glest_game/libpng14.dll" ]] && cp source/win32_deps/lpng141/libpng14.dll data/glest_game/libpng14.dll
[[ -f "data/glest_game/libjpeg-8.dll" ]] && cp source/win32_deps/lib/libjpeg.dll data/glest_game/libjpeg-8.dll
[[ -f "data/glest_game/libvorbisfile-3.dll" ]] && cp source/win32_deps/lib/libvorbisfile.dll data/glest_game/libvorbisfile-3.dll
[[ -f "data/glest_game/libvorbis-0.dll" ]] && cp source/win32_deps/lib/libvorbis.dll data/glest_game/libvorbis-0.dll
[[ -f "data/glest_game/libogg-0.dll" ]] && cp source/win32_deps/lib/libogg.dll data/glest_game/libogg-0.dll
[[ -f "data/glest_game/OpenAL32.dll" ]] && cp source/win32_deps/lib/OpenAL32.dll data/glest_game/OpenAL32.dll
[[ -f "data/glest_game/SDLmain.dll" ]] && cp source/win32_deps/lib/SDLmain.dll data/glest_game/SDLmain.dll
[[ -f "data/glest_game/SDL.dll" ]] && cp source/win32_deps/lib/SDL.dll data/glest_game/SDL.dll
[[ -f "data/glest_game/wxmsw28u_gcc_custom.dll" ]] && cp source/win32_deps/wxWidgets-2.8.10/lib/wxmsw28u_gcc_custom.dll data/glest_game/wxmsw28u_gcc_custom.dll
[[ -f "data/glest_game/wxmsw28u_gl_gcc_custom.dll" ]] && cp source/win32_deps/wxWidgets-2.8.10/lib/wxmsw28u_gl_gcc_custom.dll data/glest_game/wxmsw28u_gl_gcc_custom.dll
[[ -f "data/glest_game/zlib.dll" ]] && cp source/win32_deps/lib/zlib.dll data/glest_game/zlib.dll
[[ -f "data/glest_game/mingwm10.dll" ]] && cp /usr/share/doc/mingw32-runtime/mingwm10.dll data/glest_game/mingwm10.dll
