FROM nginx

MAINTAINER idanbenyair

ARG ENVIRON
ARG WORKER_PROCESS
ARG WORKER_RLIMIT_NOFILE
ARG WORKER_CONNECTIONS
#RUN echo $ENVIRON

#Set environment
ENV ENVIRON=$ENVIRON

#Run updates and install text editor
RUN apt-get update -y
RUN apt-get install vim -y

#Create a soft link between access.log and stdout, same for error.log and stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

#Insert nginx.conf contents
RUN echo "user  nginx;\n" \
         "worker_processes  $WORKER_PROCESS;\n" \
         "worker_rlimit_nofile $WORKER_RLIMIT_NOFILE;\n" \
         "error_log  /var/log/nginx/error.log warn;\n" \
         "pid        /var/run/nginx.pid;\n" \
         " events {\n" \
         "     worker_connections  $WORKER_CONNECTIONS;\n" \
         " }\n" \
         " http {\n" \
         "       server {\n" \
         "             listen 80 default_server;\n" \
         "             listen [::]:80 default_server ipv6only=on;\n" \
         "             root /var/www;\n" \
         "             index index.html index.htm;\n" \
         "       }\n" \
         "     include       /etc/nginx/mime.types;\n" \
         "     default_type  application/octet-stream;\n" \
         "     log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '\n" \
         "                       '$status $body_bytes_sent "$http_referer" '\n" \
         "                       '"$http_user_agent" "$http_x_forwarded_for"';\n" \
         "     access_log  /var/log/nginx/access.log  main;\n" \  
         "     sendfile        on;\n" \
         "     #tcp_nopush     on;\n" \
         "     keepalive_timeout  65;\n" \
         "     include /etc/nginx/conf.d/*.conf;\n" \
         " }\n" > /etc/nginx/nginx.conf

#Create /var/www directory
RUN mkdir /var/www

#Insert index.html contents
RUN echo "<!DOCTYPE html>\n" \
         "<html>\n" \
         "<head>\n" \
         "<title>Welcome to nginx!</title>\n" \
         "<style>\n" \
         "   body {\n" \
         "       width: 35em;\n" \
         "       margin: 0 auto;\n" \
         "       font-family: Tahoma, Verdana, Arial, sans-serif;\n" \
         "   }\n" \
         "</style>\n" \
         "</head>\n" \
         "<body>\n" \
         "<h1>This is "$ENVIRON"</h1>\n" \
         "</body>\n" \
         "</html>\n" > /var/www/index.html

#Expose port 80 to the world
EXPOSE 80
