#FROM ubuntu:latest

FROM debian:buster
USER root


RUN apt update  
RUN apt install -y python3 git nano wget curl

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



