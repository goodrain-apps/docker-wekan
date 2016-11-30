FROM ubuntu:14.04

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E1DD270288B4E6030699E45FA1715D88E1DF1F24 \
#    && echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu trusty main" >> /etc/apt/sources.list \
#    && sed -Ei '1,$s/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/cn.archive.ubuntu.com\/ubuntu\//g' /etc/apt/sources.list \
RUN apt-get update -q \
    && apt-get upgrade -y \
    && apt-get install -y build-essential python wget \
    && apt-get install -y -d postfix \
    && echo 'postfix postfix/mailname text wekan.goodrain.com' | debconf-set-selections \
    && echo 'postfix postfix/main_mailer_type select Internet Site' | debconf-set-selections \
    && apt-get install -y postfix

WORKDIR /app

# nodejs
RUN wget -c https://nodejs.org/dist/v0.10.40/node-v0.10.40.tar.gz \
    && tar zxvf node-v0.10.40.tar.gz \
    && cd node-v0.10.40 \
    && ./configure \
    && make \
    && make install

# wekan
RUN cd /app \
    && apt-get install -y wget \
    && wget -c https://github.com/wekan/wekan/releases/download/v0.10.1/wekan-0.10.1.tar.gz \
    && tar zxvf wekan-0.10.1.tar.gz \
    && cd bundle/programs/server \
    && npm install


COPY docker-entrypoint.sh /app/

#EXPOSE 5000
RUN apt-get autoremove \
    && rm -rf /var/lib/apt/list/*

ENTRYPOINT ["/app/docker-entrypoint.sh"]


