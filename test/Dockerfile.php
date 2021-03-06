from dkundel/sslaunch

RUN apt-get install -y php-curl

RUN curl -sS https://getcomposer.org/installer |  php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /sdk-starter-kits/php

RUN echo "Downloading the SDK Starter PHP"
RUN wget -O php.zip "https://github.com/TwilioDevEd/sdk-starter-php/archive/master.zip"

RUN echo "Unzipping SDK Starter PHP"
RUN unzip php.zip
RUN rm php.zip

WORKDIR /sdk-starter-kits/php/sdk-starter-php-master
RUN ls -l
RUN cp webroot/.env.example webroot/.env

EXPOSE 8000
RUN composer install


CMD ["php", "-S", "0.0.0.0:8000", "-t", "webroot"]