FROM openjdk:17-jdk-slim
EXPOSE 8099
# 최초 gradle 실행 필요함(script에서 bootJar 실행하는 방법으로 하면 될 듯) lib Dir Active 되지 않으면 Actions 실행 시 File 못찾는 이슈
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]