## Dockerfile ofr building a docker imapsync image with WebUI

# docker build -t mrickl/imapsyncwithwebui

#Documentation cooming Soon

FROM debian:buster

LABEL   maintainer="Marcel Rickl <mail@marcelrickl.de" \
        description="Imapsync with WebUI" \
        #documentation="https://marcelrickl.de/docker/imapsyncwithwebui.html" 

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
  curl                         \
  apache2

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/www/apache2ctl

RUN mkdir -p /usr/lib/cgi-bin
RUN rm -f /var/www/html/index.html

#always pull the latest version of imapsync
RUN curl https://raw.githubusercontent.com/imapsync/imapsync/master/imapsync > /usr/lib/cgi-bin/imapsync
RUN chmod +x /usr/lib/cgi-bin/imapsync

#copy the webui files
COPY html /var/www/html
RUN ln -s /var/www/html/imapsync_form_extra.html /var/www/html/index.html

#copy apache conf file
COPY apache.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod cgi

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh"]
EXPOSE 80