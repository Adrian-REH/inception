# Description memory

## Infra-structure diagram

![alt text](image.png)



# Inception

 wget ftp://ftpuser:ftppassword@127.0.0.1:2222/wp-config.php 

# config


 docker stop $(docker ps -aq) && \
 docker rm $(docker ps -aq) && \
 docker rmi $(docker images -aq) && \
docker volume rm $(docker volume ls -q)

