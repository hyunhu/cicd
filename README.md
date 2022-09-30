# CI / CD
# Deployment Automation

## WorkFlow
- Gradle Build - Docker Build & Push - Deploy - Notification
## Github Actions
- [Github Actions](https://docs.github.com/en/actions)

### Create Github-Actions.yml

```
name: Sample CI/CD 

on:
  push:
    branches: 
      - main
      - scheduler
    tags:
      - '**'
  pull_request:
    branches: 
      - main
      - scheduler

permissions:
  contents: read

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Set up JDK 17
      uses: actions/setup-java@v3
      with:
        java-version: '17'
        distribution: 'temurin'
    - name: Gradle Caching
      uses: actions/cache@v3
      with:
        path: |
          ~/.gradle/caches
          ~/.gradle/wrapper
        key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
        restore-keys: |
          ${{ runner.os }}-gradle-
    - name: Build with Gradle
      run: ./gradlew build -x test
    - uses: docker/setup-buildx-action@v1
      name: Set up Docker Buildx
    - uses: docker/login-action@v1
      name: Login to DockerHub
      with:
        username: ${ { secrets.DOCKER_USERNAME } }
        password: ${ { secrets.DOCKER_TOKEN } }
    - uses: docker/build-push-action@v2
      name: Build and push
      with:
        context: .
        file: ./Dockerfile
        platforms: linux/amd64
        push: true
        tags: ${ { steps.docker_meta.outputs.tags } }
        labels: ${ { steps.docker_meta.outputs.labels } }


```

## DockerFile
```
FROM openjdk:17-jdk-slim
EXPOSE 8099
ARG JAR_FILE=/build/libs/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
```
