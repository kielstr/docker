FROM debian

RUN apt-get -y update

RUN apt-get -y install \
	apt-utils \
	curl \
	perl-modules-5.24 \
	build-essential \
	starman \
	libplack-middleware-deflater-perl \
	procps \
	libnet-address-ip-local-perl \
	libcatalyst-perl \
	less 

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN curl -L cpanmin.us | perl - Mojolicious
RUN cpanm -i -n Catalyst::Devel
