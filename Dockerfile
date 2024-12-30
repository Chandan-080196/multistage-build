FROM alpine AS git
RUN apk update && apk add git
WORKDIR /app
RUN https://github.com/OpqTech/java-onlinebookstore.git

FROM maven:amazoncorretto AS build
COPY --from=git /app/* /usr/app/
RUN mvn clean install

FROM tomcat:latest
COPY --from=build /usr/app/target/*.war /usr/locat/tomcat/webapps/
