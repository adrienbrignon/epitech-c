from fedora

RUN dnf -y install make automake gcc-c++ cmake git gcovr \
    && dnf clean all

RUN git clone --recursive https://github.com/Snaipe/Criterion criterion \
    && cd criterion \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
             -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_INSTALL_LIBDIR=lib \
             .. \
    && make \
    && make install \
    && cd ../../ \
    && rm -rf criterion \
    && echo "/usr/local/lib" > /etc/ld.so.conf.d/criterion.conf \
    && ldconfig
