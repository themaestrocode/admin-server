# --- Build Stage ---
FROM maven:3.9-eclipse-temurin-25 AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Runtime Stage ---
FROM eclipse-temurin:25-jre

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

ENTRYPOINT ["sh", "-c", "java -jar app.jar --server.port=$PORT"]