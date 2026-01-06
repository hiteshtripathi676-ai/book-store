# Build stage
FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM tomcat:10.1-jdk11

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Configure Tomcat to disable shutdown port (prevents repeated warnings on cloud platforms)
# Replace shutdown port with -1 and set shutdown command to empty to fully disable
RUN sed -i 's/<Server port="8005" shutdown="SHUTDOWN">/<Server port="-1" shutdown="DISABLED">/g' /usr/local/tomcat/conf/server.xml

# Copy WAR file
COPY --from=build /app/target/ebook-store.war /usr/local/tomcat/webapps/ROOT.war

# Set environment variables for Tomcat
ENV CATALINA_OPTS="-Dorg.apache.catalina.startup.EXIT_ON_INIT_FAILURE=true"

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
