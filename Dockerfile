FROM epitechcontent/epitest-docker:latest
LABEL maintainer="Adrien Brignon <adrien.brignon@epitech.eu>"

RUN dnf -y install \
      doxygen \
      ruby \
      valgrind \
      expect \
      tcsh \
      libXrandr-devel \
 && dnf clean all -y

RUN git clone --depth=1 https://github.com/ronanboiteau/NormEZ NormEZ \
    && cd NormEZ \
    && install NormEZ.rb /usr/local/bin/normez \
    && cd .. \
    && rm -rf NormEZ
