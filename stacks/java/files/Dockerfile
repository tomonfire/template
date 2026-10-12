# syntax=docker/dockerfile:1
FROM maven:3-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml ./
RUN mvn -B -ntp -q dependency:go-offline
COPY src ./src
RUN mvn -B -ntp -q package -DskipTests

FROM eclipse-temurin:21-jre
RUN useradd --uid 10001 --no-create-home app
COPY --from=build /src/target/app.jar /app/app.jar
USER app
ENV PORT=8080
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]
