#/bin/bash

sudo docker stop cacophony-api-test
sudo docker rm cacophony-api-test

sudo docker build . -t cacophony-api
sudo docker run -itd --name cacophony-api-test cacophony-api

sudo docker cp . cacophony-api-test:/ 

sudo docker cp . cacophony-api-test:/
sudo docker exec cacophony-api-test bash -c "$@ pwd && ls /"
sudo docker exec cacophony-api-test bash -c "$@ node /Server.js"
