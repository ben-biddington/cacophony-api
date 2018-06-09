# sudo docker build --no-cache . -t cacophony-api && sudo docker run -it cacophony-api

FROM ubuntu

RUN apt-get update
RUN apt-get install -y git curl tree python3 python3-pip
RUN python3 -m pip install --user
RUN python3 -m pip install --user virtualenv