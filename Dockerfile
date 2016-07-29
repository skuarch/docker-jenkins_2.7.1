FROM ubuntu:16.04

MAINTAINER Alfredo Bello <skuarch@yahoo.com.mx>

ADD ./jdk-8u91-linux-x64.tar.gz ./jenkins.war ./apache-tomcat-8.0.33.tar.gz ./apache-maven-3.3.9-bin.tar.gz ./tomcat-users.xml ./startup.sh /tmp/

## install java
RUN mkdir /usr/lib/jvm && \    
    mv /tmp/jdk1.8.0_91 /usr/lib/jvm/ && \
    chmod 777 -R /usr/lib/jvm && \        
    update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_91/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_91/bin/javac" 1 && \
    update-alternatives --install "/usr/bin/javah" "javah" "/usr/lib/jvm/jdk1.8.0_91/bin/javah" 1 && \
    JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \
    export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_91/bin/java && \

## install jenkins
    mv /tmp/apache-tomcat-8.0.33 /opt/tomcat && \
    mv /tmp/jenkins.war /opt/tomcat/webapps && \    
    HUDSON_HOME=/opt/tomcat && \
    CATALINA_HOME=/opt/tomcat && \
    export HUDSON_HOME=/opt/tomcat && \
    export CATALINA_HOME=/opt/tomcat && \

## create tomcat user
   rm /opt/tomcat/conf/tomcat-users.xml && \    
   mv /tmp/tomcat-users.xml /opt/tomcat/conf/ && \       

## install git
   apt-get update -y && \
   apt-get install git-core -y -f && \
   git config --global user.name "jenkins" && \
   git config --global user.email "jenkins@localhost" && \

## install maven
   mv /tmp/apache-maven-3.3.9 /usr/local/ && \      
   M2_HOME=/usr/local/apache-maven-3.3.9 && \
   M2=$M2_HOME/bin && \
   MAVEN_OPTS="-Xms256m -Xmx512m" && \
   PATH=$M2:$PATH && \
   JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91 && \    
   export M2_HOME && \
   export M2 && \
   export MAVEN_OPTS && \
   export JAVA_HOME  && \
   ln -s /usr/local/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \   

## startup.sh
   mv /tmp/startup.sh / && \   
   chmod +x /startup.sh && \

## clean up    
   rm -rf /tmp/*

WORKDIR /opt/tomcat
VOLUME /opt/tomcat
EXPOSE 9090 5000

CMD /./startup.sh
