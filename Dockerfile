from fedora

# Install required packages and dependencies.
RUN dnf -y install --allowerasing \
        make automake gcc-c++ cmake git gcovr ruby findutils valgrind expect \
        ncurses-devel ncurses-compat-libs freetype-devel libXrandr-devel \
        libX11-devel libudev-devel libogg-devel libglvnd-glx libvorbis-devel \
        flac-devel openal-soft-devel libglvnd-glx mesa-libGL-devel \
    && dnf clean all

# Add local shared libraries to system library path.
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf \
    && ldconfig

# Install SFML and its C bindings.
RUN git clone --depth 1 https://github.com/SFML/SFML -b 2.5.x SFML \
    && mkdir SFML/build \
    && cd SFML/build \
    && cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make install \
    && ldconfig \
    && cd ../../ \
    && rm -rf SFML \
    && git clone --depth 1 https://github.com/SFML/CSFML -b 2.5 CSFML \
    && mkdir CSFML/build \
    && cd CSFML/build \
    && cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr/local \
    && make install \
    && ldconfig \
    && cd ../../ \
    && rm -rf CSFML

# Install Criterion.
RUN git clone --recursive https://github.com/Snaipe/Criterion criterion \
    && cd criterion \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
             -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_INSTALL_LIBDIR=lib \
             .. \
    && make install \
    && ldconfig \
    && cd ../../ \
    && rm -rf criterion

# Install NormEZ.
RUN git clone https://github.com/ronanboiteau/NormEZ NormEZ \
    && cd NormEZ \
    && mv NormEZ.rb /usr/local/bin/normez \
    && cd .. \
    && rm -rf NormEZ \
    && chmod +x /usr/local/bin/normez
