# --- Build Stage ---
FROM maven:3.9.8-eclipse-temurin-25 AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Runtime Stage ---
FROM eclipse-temurin:25

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8090

ENTRYPOINT ["java", "-jar", "app.jar"]
