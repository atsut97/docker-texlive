FROM debian:bullseye-slim

ENV LANG=C.UTF-8

# CTAN_HOST should be chosen from the list of CTAN mirrors:
# https://ctan.org/mirrors/mirmon
ARG CTAN_HOST="https://mirror.ctan.org"
# ARG CTAN_HOST="https://ftp.jaist.ac.jp/pub/CTAN"

# Install dependencies and necessary tools.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    dbus-x11 \
    ghostscript \
    git \
    inkscape \
    libpaper-utils \
    make \
    pstoedit \
    sensible-utils \
    texlive-binaries \
    ucf \
    wget \
    xdg-utils \
    xzdec \
    && rm -rf /var/lib/apt/lists/*

# Copy the profile file to perform the installation.
COPY texlive.profile /tmp/install-tl-unx/texlive.profile

# Install TeX Live.
RUN wget -qO- ${CTAN_HOST}/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar xz -C /tmp/install-tl-unx --strip-components=1 && \
    perl /tmp/install-tl-unx/install-tl \
    --no-gui \
    --repository=${CTAN_HOST}/systems/texlive/tlnet \
    --profile=/tmp/install-tl-unx/texlive.profile && \
    # Fix symbolic links to binaries.
    tlversion=$(cat /tmp/install-tl-unx/release-texlive.txt | head -n 1 | awk '{ print $5 }') && \
    for bin in /usr/local/texlive/$tlversion/bin/x86_64-linux/*; do \
      ln -s $bin /usr/local/bin; \
    done && \
    tlmgr option repository ${CTAN_HOST}/systems/texlive/tlnet && \
    tlmgr install \
    latexmk \
    noto \
    && rm -rf /tmp/install-tl-unx

WORKDIR /work

CMD ["bash"]
