ARG BUILD_FROM=ghcr.io/hassio-addons/base-debian:14.3.2
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

# نصب ffmpeg و وابستگی‌ها
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg git build-essential cmake qtbase5-dev qtmultimedia5-dev \
    libqt5serialport5-dev libusb-1.0-0-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    && rm -rf /var/lib/apt/lists/*

# دانلود HyperHDR
RUN git clone --depth=1 https://github.com/awawa-dev/HyperHDR.git /hyperhdr

# بیلد
WORKDIR /hyperhdr
RUN mkdir build && cd build && cmake .. && make -j$(nproc) && make install

# کپی LUT ها
RUN mkdir -p /usr/local/share/hyperhdr/LUT \
    && cp -r /hyperhdr/bin/Lut /usr/local/share/hyperhdr/LUT

CMD ["/usr/local/bin/HyperHDR", "--verbose"]
