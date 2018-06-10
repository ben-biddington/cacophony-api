#/bin/bash
#set -e

if [ -f docker-container-pid ]; then
    pid="$(cat docker-container-pid)"

    #echo $pid

    echo "Stopping container <$pid>"
    sudo docker stop $pid &> /dev/null

    sleep 5
    
    echo "Removing container <$pid>"
    sudo docker rm $pid &> /dev/null

    rm docker-container-pid
fi

#exit 1

sudo docker build . -t cacophony-api
sudo docker run -itd --rm --name cacophony-api-test -p 1080:1080 cacophony-api | tee > docker-container-pid

sudo docker cp . cacophony-api-test:/
sudo docker exec cacophony-api-test bash -c "$@ rm -r /node_modules"
sudo docker exec cacophony-api-test bash -c "$@ echo 'npm install...'        && npm install &> echo '.'"
sudo docker exec cacophony-api-test bash -c "$@ echo 'migrating database...' && node_modules/sequelize-cli/bin/sequelize db:migrate --config config/app.js"
sudo docker exec cacophony-api-test bash -c "$@ node /Server.js"
