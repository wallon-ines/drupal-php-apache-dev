FROM florenttorregrosa/docker-drupal:php7

ENV DEBIAN_FRONTEND noninteractive

RUN docker-php-pecl-install \
        xdebug

# Install npm

RUN apt-get update && apt-get install -y apt-transport-https

RUN printf "deb https://deb.nodesource.com/node_8.x jessie main\ndeb-src https://deb.nodesource.com/node_8.x jessie main" > /etc/apt/sources.list.d/nodesource.list

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

RUN apt-get update && apt-get install -y nodejs && apt-get clean \
    && npm install --global gulp-cli

# Install Coder.
RUN composer global require drupal/coder:8.2.*

# Install Drupal console.
RUN curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && drupal init

RUN rm -rf /var/www/html && ln -s /project/web /var/www/html

# Xdebug conf.
COPY xdebug.ini /usr/local/etc/php/conf.d/conf-xdebug.ini
