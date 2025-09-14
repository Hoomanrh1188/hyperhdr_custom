# استفاده از تصویر پایه Alpine
FROM ghcr.io/home-assistant/aarch64-base:latest

# نصب ابزارهای مورد نیاز با استفاده از apk
RUN apk update && \
    apk add --no-cache \
    git \
    build-base \
    cmake \
    qt5-qtbase-dev \
    qt5-qtmultimedia-dev \
    qt5-qtserialport-dev \
    libusb-dev \
    ffmpeg \
    bash

# کپی فایل‌های مورد نیاز به داخل کانتینر
COPY . /app

# تنظیم دایرکتوری کاری
WORKDIR /app

# دستور پیش‌فرض برای اجرای برنامه
CMD ["./your_program"]
