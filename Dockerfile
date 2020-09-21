FROM epitechcontent/epitest-docker:latest

RUN dnf -y install \
      doxygen \
      ruby \
      valgrind \
      expect \
      tcsh

RUN git clone --depth=1 https://github.com/ronanboiteau/NormEZ NormEZ \
    && cd NormEZ \
    && install NormEZ.rb /usr/local/bin/normez \
    && cd .. \
    && rm -rf NormEZ
