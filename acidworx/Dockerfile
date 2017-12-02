FROM kiels-laptop:5000/debian_dancer2_starman_app AS acidworx

RUN apt-get update -y && apt-get install -y perl-doc && apt-get install -y libdancer-perl

RUN apt-get install -y libdancer-plugin-database-core-perl;

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN apt-get -y install libmodule-build-perl

RUN cpanm -i Dancer2::Plugin::Email

RUN cpanm -i Dancer2::Plugin::Auth::Extensible
RUN cpanm -i Dancer2::Plugin::Auth::Extensible::Provider::Database

RUN apt-get update && apt-get install -y libany-moose-perl 

RUN cpanm -i Moose

RUN apt-get -y install mysql-client

RUN cpanm -i -n Plack::Middleware::ReverseProxy Plack::Middleware::ReverseProxyPath

COPY ./Database.pm /usr/share/perl5/Dancer2/Plugin/Database.pm

EXPOSE 8081

CMD ["plackup", "-R /acidworx/lib", "-s", "Starman", "--workers=10", "-p", "8081", "-a", "/acidworx/bin/acidworx.psgi"]
