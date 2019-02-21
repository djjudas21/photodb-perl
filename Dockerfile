FROM perl:latest
LABEL maintainer="Jonathan Gazeley <me@jonathangazeley.com>"

# set perl environment variables
ENV PERL_PATH=/opt/photodb
ENV PERL5LIB=$PERL_PATH:$PERL_PATH/lib/perl5:$PERL5LIB
ENV PERL_MM_OPT="INSTALL_BASE=$PERL_PATH"
ENV PERL_MB_OPT="--install_base $PERL_PATH"
ENV PATH="$PERL_PATH/bin:$PATH"

# install photodb
COPY . /opt/photodb
WORKDIR /opt/photodb

# Persistent storage for ini file
RUN mkdir /photodb
VOLUME /photodb

# install deps
RUN cpanm --installdeps -q -n --force -l $PERL_PATH . \
	&& rm -rf ~/.cpanm

# run photodb
ENTRYPOINT ["perl", "-wT", "-I/opt/photodb/lib/perl5", "/opt/photodb/photodb"]
