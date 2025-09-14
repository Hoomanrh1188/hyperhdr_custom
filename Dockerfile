# Base image
ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian:14.3.2
FROM ${BUILD_FROM}

# Set environment
ENV LANG C.UTF-8

# نصب ابزارهای لازم
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    cmake \
    qtbase5-dev \
    qtmultimedia5-dev \
    libqt5serialport5-dev \
    libusb-1.0-0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    ffmpeg \
    bash \
    && rm -rf /var/lib/apt/lists/*

# دانلود HyperHDR
RUN git clone --depth=1 https://github.com/awawa-dev/HyperHDR.git /hyperhdr

# Build HyperHDR
WORKDIR /hyperhdr
RUN mkdir build && cd build && cmake .. && make -j$(nproc) && make install

# کپی LUT ها برای YUV/MJPEG
RUN mkdir -p /usr/local/share/hyperhdr/LUT \
    && cp -r /hyperhdr/bin/Lut /usr/local/share/hyperhdr/LUT

# مسیر اجرای پیش‌فرض
CMD ["/usr/local/bin/HyperHDR", "--verbose"]
