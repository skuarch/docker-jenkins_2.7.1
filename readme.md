docker build --no-cache=true -t skuarch/jenkins:2.7.1 .
docker run --name jenkins -i -t -d -p 9090:8080 -p 5000:5000 skuarch/jenkins:2.7.1
docker start jenkins
