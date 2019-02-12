FROM debian:buster
RUN echo 'deb-src http://ftp.debian.org/debian buster main' >> /etc/apt/sources.list
RUN echo 'deb-src http://ftp.debian.org/debian sid main' >> /etc/apt/sources.list
RUN apt-get update && apt-get install wget gnupg2 -y
RUN echo 'deb http://apt.llvm.org/unstable/ llvm-toolchain-7 main' >> /etc/apt/sources.list
RUN echo 'deb-src http://apt.llvm.org/unstable/ llvm-toolchain-7 main' >> /etc/apt/sources.list
RUN echo 'Package: *' >> /etc/apt/preferences.d/be-stable
RUN echo 'Pin: release a=stable-backports' >> /etc/apt/preferences.d/be-stable
RUN echo 'Pin-Priority: 100' >> /etc/apt/preferences.d/be-stable
RUN echo 'Package: *' >> /etc/apt/preferences.d/be-stable
RUN echo 'Pin: release a=stable' >> /etc/apt/preferences.d/be-stable
RUN echo 'Pin-Priority: 999' >> /etc/apt/preferences.d/be-stable
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update
RUN apt-get install -y clang-6.0 lld-6.0 llvm-6.0-dev python-jinja2 \
	gsettings-desktop-schemas-dev xvfb libre2-dev libelf-dev libvpx-dev \
	libkrb5-dev libexif-dev libxslt1-dev libpam0g-dev \
	libsnappy-dev libavutil-dev libavcodec-dev libavformat-dev libjsoncpp-dev \
	libspeechd-dev libminizip-dev libhunspell-dev libopenjp2-7-dev \
	libmodpbase64-dev libnss3-dev libnspr4-dev libcups2-dev libjs-jquery-flot \
	make ninja-build wget flex yasm wdiff gperf bison valgrind x11-apps \
	libglew-dev libgl1-mesa-dev libglu1-mesa-dev libegl1-mesa-dev \
	libgles2-mesa-dev mesa-common-dev libxt-dev libgbm-dev libxss-dev \
	libpci-dev libcap-dev libdrm-dev libflac-dev libudev-dev libopus-dev \
	libwebp-dev libxtst-dev libgtk-3-dev liblcms2-dev libpulse-dev \
    libasound2-dev libusb-1.0-0-dev libevent-dev libgcrypt20-dev libva-dev \
    libvpx-dev debhelper libglew-dev git packaging-dev python3 ninja-build libllvm-7-ocaml-dev libllvm7 llvm-7 llvm-7-dev llvm-7-doc llvm-7-examples llvm-7-runtime \
    clang-7 clang-tools-7 clang-7-doc libclang-common-7-dev libclang-7-dev libclang1-7 clang-format-7 python-clang-7 lld-7 libglew-dev libglew-dev
RUN apt-get build-dep -y chromium
RUN wget http://ftp.us.debian.org/debian/pool/main/s/srtp/libsrtp0_1.4.5~20130609~dfsg-2_amd64.deb && dpkg -i libsrtp0_1.4.5~20130609~dfsg-2_amd64.deb
RUN wget http://ftp.us.debian.org/debian/pool/main/s/srtp/libsrtp0-dev_1.4.5~20130609~dfsg-2_amd64.deb && dpkg -i libsrtp0-dev_1.4.5~20130609~dfsg-2_amd64.deb
WORKDIR /home/ungoogler/build
RUN git clone https://github.com/Eloston/ungoogled-chromium.git
WORKDIR /home/ungoogler/build/ungoogled-chromium
RUN mkdir -p build/src && ls
RUN ./get_package.py debian_buster build/src/debian
WORKDIR /home/ungoogler/build/ungoogled-chromium/build/src
RUN debian/rules setup-local-src
RUN dpkg-buildpackage -b -uc



