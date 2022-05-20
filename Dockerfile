FROM ubuntu:bionic
MAINTAINER antimodes201

ENV SAVE_NAME="world1"
ENV INSTANCE_NAME "default"
ENV TZ "America/New_York"
ENV GAME_PORT "27015"
ENV QUERY_PORT "27016"


RUN export DEBIAN_FRONTEND noninteractive && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y net-tools \ 
	tar \
	unzip \
	curl \
	wget \
	tzdata \
	xz-utils \
	gnupg2 \
	software-properties-common \
	xvfb && \
    curl -s https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key | apt-key add - && \
    apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./' && \
    apt update && \
    apt install libfaudio0 libasound2-plugins:i386 -y && \	
	wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
	mv winehq.key /usr/share/keyrings/winehq-archive.key && \
	wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/bionic/winehq-bionic.sources && \
	mv winehq-bionic.sources /etc/apt/sources.list.d && \
	apt update && \
	apt install -y --install-recommends winetricks \
	winehq-stable && \
    rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /vrising \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /vrising \
		&& chown steamuser:steamuser /scripts 

USER steamuser

# Make a volume
# contains configs and world saves
VOLUME /vrising

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $QUERY_PORT/udp

# Make a volume
# contains configs and world saves
VOLUME /vrising

CMD ["/scripts/start.sh"]