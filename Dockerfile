# sudo docker build --no-cache . -t cacophony-api && sudo docker run -it cacophony-api

FROM ubuntu

RUN apt-get update
RUN apt-get install -y git curl tree python3 python3-pip nodejs 
RUN python3 -m pip install --user
RUN python3 -m pip install --user virtualenv

# Server

RUN git clone git@github.com:TheCacophonyProject/cacophony-api.git && cd cacophony-api
RUN npm install
RUN cp config/app_TEMPLATE.js config/app.js
RUN node Server.js &

# Database