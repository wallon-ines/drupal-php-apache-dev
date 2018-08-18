FROM libert/drupal-php-apache:php-7.0

ENV DEBIAN_FRONTEND noninteractive

# Install npm & vim
RUN apt-get update && apt-get install -y \
        apt-transport-https \
        gnupg2

RUN printf "deb https://deb.nodesource.com/node_8.x jessie main\ndeb-src https://deb.nodesource.com/node_8.x jessie main" > /etc/apt/sources.list.d/nodesource.list \
    && curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

RUN apt-get update && apt-get install -y \
        nodejs \
        vim \
    && apt-get clean && apt-get autoremove -q

# Configure vim
RUN git clone --depth=1 http://gitlab.famillewallon.com/ines/custom-vim.git ~/.vim_runtime \
    && /bin/sh ~/.vim_runtime/install_awesome_vimrc.sh

# Install xdebug
RUN docker-php-pecl-install \
        xdebug

# Install Gulp
RUN npm install --global gulp-cli

# Install grunt
RUN npm install --global grunt

# Install Coder and configure Code sniffer.
RUN composer global require drupal/coder:8.2.* \
    && composer global require dealerdirect/phpcodesniffer-composer-installer \
    && composer clear-cache \
    && echo 'alias drupalcs="phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc \
    && echo 'alias drupalcsp="phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc \
    && echo 'alias drupalcbf="phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"' >> $HOME/.bashrc

# Install Drupal console.
RUN curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && drupal init

WORKDIR /project/


# Xdebug conf.
COPY xdebug.ini /usr/local/etc/php/conf.d/conf-xdebug.ini
