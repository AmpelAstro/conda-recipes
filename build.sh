#!/bin/bash

mkdir -vp ${PREFIX}/bin;
echo $PREFIX
export CFLAGS="-Wall -g -m64 -pipe -O2 -march=x86-64 -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
echo 'gcc version' 
gcc -v

ARCH="$(uname 2>/dev/null)"


LinuxInstallation() {
    # Build dependencies:
    # - libXpm-devel
    # - libX11-devel

    
    chmod +x configure;
    
    make distclean;

  #  ./configure \
  #      ${ARCH,,*}x8664gcc \
  #      --minimal \
  #      --enable-x11 \
  #      --enable-python \
  #      --enable-xml \
  #      --with-python-incdir=`python3.4-config --exec-prefix`/include/python3.4m \
  #      --with-python-libdir=`python3.4-config --exec-prefix`/lib \
  #      --etcdir=${PREFIX}/etc/root \
  #      --prefix=${PREFIX} \
   #      || return 1;
        #--enable-roofit \
        # --enable-x11 \
        #--enable-xml \
        # --prefix=${PREFIX} \
        #--enable-rpath \        
        # --enable-soversion \
        #--enable-qt \
        #--enable-minuit2 \
        #--enable-shared \
        #--enable-sqlite \
        #--enable-ssl \
        #--with-qt-incdir=${PREFIX}/include/ \
        #--with-qt-libdir=${PREFIX}/lib/ \
        #--with-ssl-incdir=${PREFIX}/include/openssl/ \
        #--with-ssl-libdir=${PREFIX}/lib/ \
        #--with-ssl-shared=yes \
        #--with-sqlite-incdir=${PREFIX}/include/  \
        #--with-sqlite-libdir=${PREFIX}/lib/  \
        #--with-python-incdir=${PREFIX}/include/python${PY_VER}/ \
        #--with-python-libdir=${PREFIX}/lib/ \
        #--with-x11-libdir=${PREFIX}/lib/ \
        
    mkdir workdir
    cd workdir

    cmake ../ -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -Dbuiltin_pcre=ON \
    -Dbuiltin_llvm=ON \
    -Dcxx11=ON \
    -Drpath=ON \
    -Droofit=ON \
    -DCMAKE_C_COMPILER=$PREFIX/bin/gcc \
    -DCMAKE_CXX_COMPILER=$PREFIX/bin/c++ \
    || return 1;     
    #-Dbuiltin_gsl=ON \

    make -j4 || return 1;
    make install || return 1;

    return 0;
}

case ${ARCH} in
    'Linux')
        LinuxInstallation || exit 1;
        ;;
    *)
        echo -e "Unsupported machine type: ${ARCH}";
        exit 1;
        ;;
esac

#POST_LINK="${PREFIX}/bin/.root-post-link.sh"
#cp -v ${RECIPE_DIR}/post-link.sh ${POST_LINK};
#chmod -v 0755 ${POST_LINK};
