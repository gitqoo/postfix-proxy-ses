docker rmi -f dockerqoo/postfix-proxy-ses
mkdir ./log
yum install docker -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&  sudo chmod +x /usr/local/bin/docker-compose  && docker-compose --version && systemctl restart docker && systemctl enable  docker && systemctl stop postfix && systemctl disable postfix

docker-compose up -d --build
#docker-compose up -d
docker ps -a
