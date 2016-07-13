FROM ubuntu:14.04

RUN apt-get update

# install system dependencies
RUN apt-get install -y python2.7 python-virtualenv git make gcc g++ cron \
  libfreetype6 fontconfig libjpeg-turbo8 libicu52 wget lighttpd
RUN ln -sf /usr/bin/python2.7 /usr/bin/python

# install nodejs
# RUN wget -O - https://deb.nodesource.com/setup | bash -
# RUN apt-get install -y nodejs

# get phantomjs
RUN mkdir /phantomjs && wget https://s3.amazonaws.com/travis-phantomjs/phantomjs-2.0.0-ubuntu-14.04.tar.bz2 -O /phantomjs/phantomjs.tar.bz2
RUN tar -xvf /phantomjs/phantomjs.tar.bz2 -C /phantomjs
RUN ln -sf /phantomjs/phantomjs /usr/bin/phantomjs


# install robotframework-selenium2library and dependencies
COPY . /tests/
WORKDIR /tests

RUN make build

# RUN mkdir -p /tests
# ADD ./package.json /tests/
# WORKDIR /tests
# RUN /phantomrobot/bin/npm install

RUN crontab /tests/scripts/tests.cron

# ENV BROWSER phantomjs

VOLUME /tests/extra

ENTRYPOINT cron & \
  lighttpd -f /tests/scripts/lighttpd.conf && \
  /tests/scripts/restart.sh & \
  /tests/scripts/start.sh "sites/**/*.robot" "/tests/var/www" & \
  /bin/bash
