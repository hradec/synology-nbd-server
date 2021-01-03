#FROM ubuntu:latest

FROM debian:buster
USER root


RUN apt update  
RUN apt-get install -y git \
		pkg-config build-essential rtorrent unzip unrar-free \
		mediainfo curl php-fpm php-cli php-geoip php-mbstring php-zip \
		nginx wget ffmpeg supervisor php-xml libarchive-zip-perl \
		libjson-perl libxml-libxml-perl irssi sox libgcrypt20  libssl-dev \
		nano libcppunit-dev libsigc++-2.0-dev automake1.11


RUN apt install -y python3

RUN rm /root/.bash_history ; \
    mkdir -p /root/synology/ ; \
    ln -s /root/synology/.bash_history /root/.bash_history

RUN echo "\
	cd /root/synology/ && \
	git clone https://github.com/SynologyOpenSource/pkgscripts-ng.git  ./pkgscripts-ng || (cd ./pkgscripts-ng && git pull && cd .. ) &&  \
	cd pkgscripts-ng && \
	cd /root/synology/ && \
	ls -l pkgscripts-ng/ && \
	touch /root/synology/.bash_history && \
	/bin/bash -i -l  \
    " > /startDocker.sh ; chmod a+x /startDocker.sh

RUN echo "\
	export PROMPT_COMMAND='history -a; history -r'\
	" > /root/.bashrc


RUN chmod a+rwx /root/synology

CMD ["/bin/bash","/startDocker.sh"]



