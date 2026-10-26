FROM tomcat:10.1-jdk17-temurin

RUN sed -i 's/<Server port="8005"/<Server port="-1"/' /usr/local/tomcat/conf/server.xml

COPY dist/LibreHotelMvc.war /usr/local/tomcat/webapps/LibreHotelMvc.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
