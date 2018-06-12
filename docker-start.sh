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
sudo docker run -itd --rm --name cacophony-api-test -p 1080:1080 -p 9001:9001 cacophony-api | tee > docker-container-pid

sudo docker cp . cacophony-api-test:/
sudo docker exec cacophony-api-test bash -c "$@ rm -r /node_modules"
sudo docker exec cacophony-api-test bash -c "$@ echo 'npm install...'        && npm install 2> /dev/null"
sudo docker exec cacophony-api-test bash -c "$@ echo 'migrating database...' && node_modules/sequelize-cli/bin/sequelize db:migrate --config config/app_test_default.js"
sudo docker exec cacophony-api-test bash -c "$@ MINIO_ACCESS_KEY=minio MINIO_SECRET_KEY=miniostorage ./minio server --address :9001 .data &> miniolog &"
sudo docker exec cacophony-api-test bash -c "$@ sleep 10" # Allowing minio to initialize
sudo docker exec cacophony-api-test bash -c "./mc config host add myminio http://127.0.0.1:9001 minio miniostorage"
sudo docker exec cacophony-api-test bash -c "./mc mb myminio/cacophony"

sudo docker exec cacophony-api-test bash -c "$@ node /Server.js --config=config/app_test_default.js"
