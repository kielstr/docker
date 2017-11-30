FROM docker.sdlocal.net/devel/stratperlbase

RUN curl -L http://cpanmin.us | perl - App::cpanminus
    
ADD modules.txt /

RUN install-cpan-modules /modules.txt

WORKDIR /container_builder

ENV PERL5LIB=/container_builder/perllib

CMD scripts/t.pl