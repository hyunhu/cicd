FROM openjdk:17-jdk-slim
EXPOSE 8099
ARG JAR_FILE=build/libs/github-actions-sample-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]