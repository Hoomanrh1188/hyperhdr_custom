# Base image باید Debian باشه
ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian:14.3.2
FROM ${BUILD_FROM}

# نصب ابزارها و ffmpeg کامل
RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential cmake \
    qtbase5-dev qtmultimedia5-dev \
    libqt5serialport5-dev libusb-1.0-0-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    ffmpeg bash \
    && rm -rf /var/lib/apt/lists/*

# ساخت دایرکتوری اپلیکیشن
WORKDIR /usr/src/app

# کپی سورس به داخل کانتینر
COPY . .

# اجرای دسترسی اجرایی روی run.sh
RUN chmod +x /usr/src/app/run.sh

# کپی LUT ها به مسیر HyperHDR
RUN mkdir -p /usr/local/share/hyperhdr/LUT \
    && cp -r ./Lut/* /usr/local/share/hyperhdr/LUT/ || true

# اجرای برنامه
CMD [ "/usr/src/app/run.sh" ]
