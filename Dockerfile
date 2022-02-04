#FROM maven:3.6.3-jdk-11-slim AS build
FROM ubuntu:latest AS build
RUN apt-get update && apt-get install -y maven
RUN mkdir /project
COPY ./goecommerce /project
WORKDIR /project
RUN mvn clean package -DskipTests
 
 
FROM ubuntu:latest
RUN apt-get update && apt-get install -y openjdk-11-jdk
RUN mkdir /app
COPY --from=build /project/target/*.jar /app/goecommerce.jar
WORKDIR /app
#CMD "tail" "-f" "/dev/null"
CMD "java" "-jar" "/app/goecommerce.jar"