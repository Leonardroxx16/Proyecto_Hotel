FROM tomcat:10.1-jdk17-temurin
COPY dist/LibreHotelMvc.war /usr/local/tomcat/webapps/LibreHotelMvc.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
