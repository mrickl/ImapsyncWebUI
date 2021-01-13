## Dockerfile ofr building a docker imapsync image with WebUI

# docker build -t mrickl/imapsyncwithwebui

#Documentation cooming Soon

FROM debian:buster

LABEL   maintainer="Marcel Rickl <mail@marcelrickl.de" \
        description="Imapsync with WebUI" \
        documentation="https://marcelrickl.de/docker/imapsyncwithwebui.html" 

RUN set -xe                 && \
  apt-get update            && \
  apt-get install -y           \
  libauthen-ntlm-perl          \
  libcgi-pm-perl               \
  libcrypt-openssl-rsa-perl    \
  libdata-uniqid-perl          \
  libencode-imaputf7-perl      \
  libfile-copy-recursive-perl  \
  libfile-tail-perl            \
  libio-socket-inet6-perl      \
  libio-socket-ssl-perl        \
  libio-tee-perl               \
  libhtml-parser-perl          \
  libjson-webtoken-perl        \
  libmail-imapclient-perl      \
  libparse-recdescent-perl     \
  libmodule-scandeps-perl      \
  libreadonly-perl             \
  libregexp-common-perl        \
  libsys-meminfo-perl          \
  libterm-readkey-perl         \
  libtest-mockobject-perl      \
  libtest-pod-perl             \
  libunicode-string-perl       \
  liburi-perl                  \
  libwww-perl                  \
  libtest-nowarnings-perl      \
  libtest-deep-perl            \
  libtest-warn-perl            \
  make                         \
  cpanminus                    \
  wget                         \
  apache2

RUN mkdir -p /var/lock/apache2
RUN mkdir -p /var/run/apache2
RUN mkdir -p /etc/apache2/mods-enabled/
RUN mkdir -p /usr/lib/cgi-bin
RUN rm /var/www/html/index.html

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LAN C

COPY imapsync /usr/lib/cgi-bin
RUN chmod +x /usr/lib/cgi-bin/imapsync

COPY imapsync_form_extra.html /var/www/html
COPY imapsync_form.css /var/www/html
COPY imapsync_form.js /var/www/html
COPY imapsyncwebui.conf /etc/apache2/sites-available/

RUN ln -s /var/www/html/imapsync_form_extra.html /var/www/html/index.html

RUN a2enmod cgi
RUN a2dissite 000-default
RUN a2ensite imapsyncwebui
RUN /etc/init.d/apache2 restart

ENV HOME /var/tmp/
WORKDIR /var/tmp/

STOPSIGNAL SIGINT
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
EXPOSE 80