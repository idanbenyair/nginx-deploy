# nginx-deploy
Dockerfile to deploy a simple nginx app

#Clone Dockerfile
```
sudo git clone https://github.com/idanbenyair/nginx-deploy.git
```

#Build container
```
build --build-arg ENVIRON=prod --build-arg WORKER_PROCESS=50 --build-arg WORKER_RLIMIT_NOFILE=100 --build-arg WORKER_CONNECTIONS=200 -t nginx:test .
```

#Run the container
```
docker run --rm -ti -p 80:80 --name nginx-deploy idanbenyair/nginx-deploy:latest
```
