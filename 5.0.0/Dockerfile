FROM debian:stretch-slim
RUN apt-get update && apt-get install varnish -y
RUN rm -Rf /var/cache/*

COPY default.vcl /etc/varnish/default.vcl
COPY devicedetect.vcl /etc/varnish/devicedetect.vcl
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && chmod 655 /etc/varnish/default.vcl /etc/varnish/devicedetect.vcl

CMD ["/entrypoint.sh"]

