from fedora

# Install required packages.
RUN dnf -y install make automake gcc-c++ cmake git gcovr ruby \
    && dnf clean all

# Install NormEZ.
RUN git clone https://github.com/ronanboiteau/NormEZ NormEZ \
    && cd NormEZ \
    && mv NormEZ.rb /usr/local/bin/normez \
    && cd .. \
    && rm -rf NormEZ \
    && chmod +x /usr/local/bin/normez

# Install Criterion.
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
