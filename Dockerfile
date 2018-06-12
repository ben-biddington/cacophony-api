# Build:                   sudo docker build --no-cache . -t cacophony-api
# Run interactive session: sudo docker run -it cacophony-api

FROM ubuntu

RUN apt-get update
RUN apt-get install tzdata && echo "New Zealand/Auckland" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get -y install postgresql-10 postgresql-client-10 postgresql-contrib-10 postgresql-server-dev-10 postgis
RUN apt-get -y install curl wget sudo make build-essential g++

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# https://minio.io/downloads.html#download-server-linux-x64
RUN wget https://dl.minio.io/server/minio/release/linux-amd64/minio
RUN chmod +x minio

# https://docs.minio.io/docs/minio-client-complete-guide
RUN wget https://dl.minio.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc

COPY docker-entrypoint.sh /

EXPOSE 1080
EXPOSE 9001
EXPOSE 2008

ENTRYPOINT ["/docker-entrypoint.sh"]