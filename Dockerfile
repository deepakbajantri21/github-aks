# Stage 1: Build with Maven
FROM maven:3.8.6 AS build
WORKDIR /app
COPY . /app
RUN mvn clean install -DskipTests

# Stage 2: Use a smaller base image
FROM openjdk:8
WORKDIR /app
COPY --from=build /app/target/spring-boot-docker.jar spring-boot-docker.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-boot-docker.jar"]
