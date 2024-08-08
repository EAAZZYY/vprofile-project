FROM tomcat:8-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Israel"

RUN rm -rf /usr/local/tomcat/webapps/*
ADD ../../target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps