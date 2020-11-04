FROM tiredofit/nginx-php-fpm:7.2
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

## Set Environment Varialbes
ENV ARGONAUT_VERSION=1.3 \
    FUSIONDIRECTORY_VERSION=1.3 \
    FUSIONDIRECTORY_PLUGINS_VERSION=1.3 \
    SCHEMA2LDIF_VERSION=1.3 \
    SMARTY_VERSION=3.1.31 \
    SMARTYGETTEXT_VERSION=1.5.1 \
    INSTANCE=default \
    NGINX_WEBROOT=/www/fusiondirectory \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_GETTEXT=TRUE \
    PHP_ENABLE_IMAGICK=TRUE \
    PHP_ENABLE_IMAP=TRUE \
    PHP_ENABLE_LDAP=TRUE

# Build Dependencies
RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .fusiondirectory-build-deps \
            coreutils \
            build-base \
            git \
            make \
            perl-dev \
            && \
    \
## Run Dependencies Installation
    apk add -t .fusiondirectory-run-deps \
        expect \
        gettext \
        gettext-lang \
        openldap \
        openldap-clients \
        perl-config-inifiles \
        perl-datetime \
        perl-ldap \
        perl-mime-base64 \
        perl-crypt-cbc \
        perl-file-copy-recursive \
        perl-io-socket-ssl \
        perl-json \
        perl-mime-tools \
        perl-net-ldap \
        perl-path-class \
        perl-term-readkey \
        perl-xml-twig \
        && \
    \
### Install Perl Dependencies that aren't available as packages
    ln -s /usr/bin/perl /usr/local/bin/perl && \
    curl -L http://cpanmin.us -o /usr/bin/cpanm && \
    chmod +x /usr/bin/cpanm && \
    cpanm -n \
            App::Daemon \
            Archive::Extract \
            HTTP::Daemon \
            JSON::Any \
            JSON::RPC \
            Log::Handler \
            Mail::Sendmail \
            Module::Pluggable \
            POE \
            POE::Component::Server::JSONRPC::Http \
            POE::Component::Schedule \
            POE::Component::Server::SimpleHTTP \
            POE::Component::Pool::Thread \
            POE::Component::SSLify \
            XML::SAX::Expat \
            && \
    \
    cp -R /usr/local/share/perl5/site_perl/* /usr/share/perl5/vendor_perl/ && \
    \
## Install Smarty3
    mkdir -p /usr/src/smarty /usr/src/smarty-gettext /usr/share/php/smarty3 && \
    curl https://codeload.github.com/smarty-php/smarty/tar.gz/v${SMARTY_VERSION} | tar xvfz - --strip 1 -C /usr/src/smarty && \
    cp -r /usr/src/smarty/libs/* /usr/share/php/smarty3 && \
    ln -s /usr/share/php/smarty3/Smarty.class.php /usr/share/php/smarty3/smarty.class.php && \
    curl https://codeload.github.com/smarty-gettext/smarty-gettext/tar.gz/${SMARTYGETTEXT_VERSION} | tar xvfz - --strip 1 -C /usr/src/smarty-gettext && \
    mkdir -p /usr/share/php/smarty3/plugins && \
    cp -R /usr/src/smarty-gettext/block.t.php /usr/share/php/smarty3/plugins/ && \
    cp -R /usr/src/smarty-gettext/tsmarty2c.php /usr/sbin && \
    chmod 750 /usr/sbin/tsmarty2c.php && \
    \
## Install Schema2LDIF
    curl https://repos.fusiondirectory.org/sources/schema2ldif/schema2ldif-${SCHEMA2LDIF_VERSION}.tar.gz| tar xvfz - --strip 1 -C /usr && \
    rm -rf /usr/CHANGELOG && \
    rm -rf /usr/LICENSE && \
    \
## Install Communication Server
    mkdir -p /usr/src/argonaut /etc/argonaut /var/log/argonaut && \
    curl https://repos.fusiondirectory.org/sources/argonaut/argonaut-${ARGONAUT_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/argonaut && \
    chmod +x /usr/src/argonaut/*/bin/* && \
    cp -R /usr/src/argonaut/argonaut-common/Argonaut /usr/share/perl5/vendor_perl/ && \
    cp -R /usr/src/argonaut/argonaut-common/XML /usr/share/perl5/vendor_perl/ && \
    cp -R /usr/src/argonaut/argonaut-common/argonaut.conf /etc/argonaut && \
    cp -R /usr/src/argonaut/argonaut-fusiondirectory/bin/* /usr/sbin && \
    cp -R /usr/src/argonaut/argonaut-fusioninventory/bin/* /usr/sbin && \
    cp -R /usr/src/argonaut/argonaut-server/bin/argonaut-server /usr/sbin && \
    cp -R /usr/src/argonaut/argonaut-server/Argonaut /usr/share/perl5/vendor_perl/ && \
    cp -R /usr/src/argonaut/*/Argonaut/ /usr/share/perl5/vendor_perl && \
    \
## Install FusionDirectory
    mkdir -p /usr/src/fusiondirectory /assets/fusiondirectory-plugins && \
    curl https://repos.fusiondirectory.org/sources/fusiondirectory/fusiondirectory-${FUSIONDIRECTORY_VERSION}.tar.gz | tar xvfz - --strip 1 -C /usr/src/fusiondirectory && \
    #git clone https://gitlab.fusiondirectory.org/fusiondirectory/fd/ /usr/src/fusiondirectory && \
    cd /usr/src/fusiondirectory && \
    curl https://repos.fusiondirectory.org/sources/fusiondirectory/fusiondirectory-plugins-${FUSIONDIRECTORY_PLUGINS_VERSION}.tar.gz | tar xvfz - --strip 1 -C /assets/fusiondirectory-plugins && \
    \
## Install Extra FusionDirectory Plugins
    git clone https://github.com/tiredofit/fusiondirectory-plugin-kopano /usr/src/fusiondirectory-plugin-kopano && \
    cp -R /usr/src/fusiondirectory-plugin-kopano/kopano /assets/fusiondirectory-plugins/ && \
    git clone https://github.com/slangdaddy/fusiondirectory-plugin-nextcloud /usr/src/fusiondirectory-plugin-nextcloud && \
    rm -rf /usr/src/fusiondirectory-plugin-nextcloud/src/DEBIAN && \
    mkdir -p /assets/fusiondirectory-plugins/nextcloud && \
    cp -R /usr/src/fusiondirectory-plugin-nextcloud/src/* /assets/fusiondirectory-plugins/nextcloud/ && \
    git clone https://github.com/gallak/fusiondirectory-plugins-seafile /usr/src/fusiondirectory-plugins-seafile && \
    rm -rf /usr/src/fusiondirectory-plugins-seafile/README.md && \
    mkdir -p /assets/fusiondirectory-plugins/seafile && \
    cp -R /usr/src/fusiondirectory-plugins-seafile/* /assets/fusiondirectory-plugins/seafile/ && \
    \
## Configure FusionDirectory
    mkdir -p /usr/src/javascript && \
    cd /usr/src/javascript && \
    curl -O http://ajax.googleapis.com/ajax/libs/prototype/1.7.1.0/prototype.js && \
    curl -O http://script.aculo.us/dist/scriptaculous-js-1.9.0.zip && \
    unzip -d . scriptaculous-js-1.9.0.zip && \
    cp -R prototype.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/scriptaculous.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/builder.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/controls.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/dragdrop.js /usr/src/fusiondirectory/html/include && \
    cp -R scriptaculous-js-1.9.0/src/effects.js /usr/src/fusiondirectory/html/include && \
    chmod 750 /usr/src/fusiondirectory/contrib/bin/* && \
    cp -R /usr/src/fusiondirectory/contrib/bin/* /usr/sbin/ && \
    cp -R /usr/src/fusiondirectory/contrib/smarty/plugins/* /usr/share/php/smarty3/plugins/ && \
    mkdir -p /var/spool/fusiondirectory/ && \
    mkdir -p /var/cache/fusiondirectory/ && \
    mkdir -p /var/cache/fusiondirectory/fai && \
    mkdir -p /var/cache/fusiondirectory/include && \
    mkdir -p /var/cache/fusiondirectory/locale && \
    mkdir -p /var/cache/fusiondirectory/template && \
    mkdir -p /var/cache/fusiondirectory/tmp && \
    mkdir -p /etc/fusiondirectory && \
    cp -R /usr/src/fusiondirectory/contrib/fusiondirectory.conf /var/cache/fusiondirectory/template/fusiondirectory.conf && \
    mkdir -p ${NGINX_WEBROOT} && \
    cp -R /usr/src/fusiondirectory/* ${NGINX_WEBROOT} && \
    fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --write-vars && \
    fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --set-fd_smarty_dir="/usr/share/php/smarty3/Smarty.class.php" --write-vars && \
    touch /etc/debian_version && \
    yes Yes | fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --check-directories --update-cache && \
    fusiondirectory-setup --set-fd_home="${NGINX_WEBROOT}" --update-locales --update-cache && \
#    sed -i -e "s#= \$_SERVER\\['PHP_SELF'\\];#= '/recovery.php';#g" ${NGINX_WEBROOT}/html/class_passwordRecovery.inc && \
    \
### Cleanup
    apk del .fusiondirectory-build-deps && \
    rm -rf /root/.cpanm && \
    rm -rf /tmp/* && \
    rm -ff /var/cache/apk/* && \
    rm -rf /usr/src/*

### Add Files
   ADD install /
