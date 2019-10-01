FROM gitpod/workspace-full:latest

ENV ANDROID_HOME=/home/gitpod/android-sdk-linux \
    FLUTTER_HOME=/home/gitpod/flutter \
    PATH=/usr/lib/dart/bin:$FLUTTER_HOME/bin:$ANDROID_HOME/tools:$PATH

USER root

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && \
    apt-get -y install build-essential dart libkrb5-dev gcc make gradle android-tools-adb android-tools-fastboot && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

USER gitpod

RUN cd /home/gitpod && \
    wget -qO flutter_sdk.tar.xz \
    https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.4-stable.tar.xz &&\
    tar -xvf flutter_sdk.tar.xz && \
    rm -f flutter_sdk.tar.xz

RUN cd /home/gitpod && \
    wget -qO android_studio.zip \
    https://dl.google.com/dl/android/studio/ide-zips/3.3.0.20/android-studio-ide-182.5199772-linux.zip && \
    unzip android_studio.zip && \
    rm -f android_studio.zip

RUN cd /home/gitpod && \
    wget android-sdk.zip \
    https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip android-sdk.zip && \
    rm -f android-sdk.zip