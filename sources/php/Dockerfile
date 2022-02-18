FROM php:8.1-fpm

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME

RUN apt-get update -y && apt-get install -y libpng-dev libicu-dev zlib1g-dev libmcrypt-dev libreadline-dev libedit-dev libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev libmongoc-dev libgmp-dev

RUN docker-php-ext-install \
    bcmath \
    gmp \
    gd \
    intl \
    opcache \
    mysqli \
    pdo_mysql \
    soap \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pear channel-discover pear.phing.info && pear install --alldeps phing/phing

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list \
    && apt update -y \
    && apt install -y symfony-cli

RUN groupadd -f -g $GROUP_ID $USER_NAME \
    && useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID $USER_NAME

COPY www.conf /usr/local/etc/php-fpm.d/www.conf

WORKDIR /symfony

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "php-fpm" ]


