# Simplesamlphp + PHP-fpm

Forked from [solazs/docker-ssp-aa-php-fpm](https://github.com/solazs/docker-ssp-aa-php-fpm)

Published image: [docker hub](https://hub.docker.com/r/hexaaproject/ssp-aa)

## Building

```
docker build -t hexaaproject/ssp-aa:latest .
```

## Usage

1. Mount your config (`config.php` and `module_aa.php`) in `/opt/simplesamlphp/config/`.
2. Mount key and cert in `/opt/simplesamlphp/cert/`.
3. Mount metadata in `/opt/simplesamlphp/metadata/`.
4. Configure apache or nginx to serve this container.
