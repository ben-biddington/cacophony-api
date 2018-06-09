# sudo docker build --no-cache . -t cacophony-api && sudo docker run -it cacophony-api

FROM ubuntu

RUN apt-get update
RUN apt-get install -y software-properties-common
#RUN add-apt-repository ppa:pitti/postgresql

RUN apt-get install -y git curl tree python3 python3-pip sudo
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs 
RUN python3 -m pip install --user
RUN python3 -m pip install --user virtualenv

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Database
RUN apt-get -y install postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5 postgresql-server-dev-9.5 postgis
RUN sudo -i -u postgres
#RUN postgres createuser -P -d -r -s docker

# Server

RUN node -v && npm -v
RUN git clone https://github.com/TheCacophonyProject/cacophony-api.git

WORKDIR cacophony-api
RUN npm install
RUN cp config/app_TEMPLATE.js config/app.js
RUN node Server.js &