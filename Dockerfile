FROM alpine:latest
LABEL maintainer="Jonathan Gazeley <me@jonathangazeley.com>"

# Install basic Perl environment
RUN apk add build-base perl perl-dev perl-app-cpanminus mariadb-dev

# set Perl environment variables
ENV PERL_PATH=/opt/photodb
ENV PERL5LIB=$PERL_PATH:$PERL_PATH/lib/perl5:$PERL5LIB
ENV PERL_MM_OPT="INSTALL_BASE=$PERL_PATH"
ENV PERL_MB_OPT="--install_base $PERL_PATH"
ENV PATH="$PERL_PATH/bin:$PATH"

# Install PhotoDB app
COPY . /opt/photodb
WORKDIR /opt/photodb

# Persistent storage for ini file
RUN mkdir -p /photodb
VOLUME /photodb

# Install Perl deps
RUN cpanm --no-wget --installdeps -q -n --force -l $PERL_PATH . \
	&& rm -rf ~/.cpanm

# Run PhotoDB in interactive mode
ENTRYPOINT ["perl", "-wT", "-I/opt/photodb/lib/perl5", "/opt/photodb/photodb.pl"]
