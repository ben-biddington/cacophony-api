# Build:                   sudo docker build --no-cache . -t cacophony-api
# Run interactive session: RUN useradd -m test && echo "test:test" | chpasswd && adduser test sudo

FROM ubuntu

RUN apt-get update
RUN apt-get -y install postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5 postgresql-server-dev-9.5 postgis
RUN apt-get -y install curl vim

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

WORKDIR cacophony-api
RUN npm install

COPY docker-entrypoint.sh /

EXPOSE 1080

ENTRYPOINT ["/docker-entrypoint.sh"]