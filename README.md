# nginx-deploy
Dockerfile to deploy a simple nginx app

#Clone Dockerfile
```
sudo git clone https://github.com/idanbenyair/nginx-deploy.git
```

#Build container
```
docker build --build-arg ENVIRON=prod --build-arg WORKER_PROCESS=50 --build-arg WORKER_RLIMIT_NOFILE=8192 --build-arg WORKER_CONNECTIONS=4096 -t nginx-deploy .
```

#Run the container
```
docker run --rm -ti -p 80:80 --name nginx-deploy nginx-deploy
```

#For production set Variables as follow:

```
ENVIRON=prod
WORKER_PROCESS=50
WORKER_RLIMIT_NOFILE=8192
WORKER_CONNECTIONS=4096
```

#For development set variables as follow:

```
ENVIRON=dev
WORKER_PROCESS=10
WORKER_RLIMIT_NOFILE=4096
WORKER_CONNECTIONS=1024
```

#Your nginx web app should be up. Check the web browser to confirm by browsing to your IP address.
