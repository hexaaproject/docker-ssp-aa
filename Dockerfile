FROM php:7.1.30-fpm-stretch
LABEL MAINTAINER Balázs SOLTÉSZ <solazs@sztaki.hu>

# Install some dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
                       libicu-dev \
                       libmemcached-dev \
                       zlib1g-dev \
                       curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG SIMPLESAMLPHP_VERSION=1.17.3

# Download and extract simplesamlphp with aa and hexaa modules
ADD https://github.com/simplesamlphp/simplesamlphp/releases/download/v$SIMPLESAMLPHP_VERSION/simplesamlphp-$SIMPLESAMLPHP_VERSION.tar.gz /opt/simplesamlphp.tar.gz
ADD https://github.com/NIIF/simplesamlphp-module-aa/archive/master.tar.gz /opt/aa.tar.gz
ADD https://github.com/NIIF/simplesamlphp-module-hexaa/archive/master.tar.gz /opt/hexaa.tar.gz

RUN cd /opt \
    && tar xzf simplesamlphp.tar.gz \
    && mv simplesamlphp-* simplesamlphp \
    && cd simplesamlphp/modules \
    && tar xzf /opt/aa.tar.gz \
    && mv simplesamlphp-module-aa-* aa \
    && tar xzf /opt/hexaa.tar.gz \
    && mv simplesamlphp-module-hexaa-* hexaa \
    && rm /opt/aa.tar.gz /opt/hexaa.tar.gz /opt/simplesamlphp.tar.gz


COPY authsources.php /opt/simplesamlphp/config/
RUN cd /opt/simplesamlphp \
    && touch modules/aa/enable \
    && cp modules/aa/config-templates/module_aa.php config/module_aa.php \
    && chown -R www-data log

COPY boot.sh /usr/local/bin/

WORKDIR /opt/simplesamlphp

CMD ["/usr/local/bin/boot.sh"]
