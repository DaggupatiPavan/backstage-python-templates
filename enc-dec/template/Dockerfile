FROM maven:3.9.4-openjdk-17-slim AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17-jre-slim

WORKDIR /app

COPY --from=builder /app/target/${{values.app_name}}-*.jar app.jar

EXPOSE ${{values.http_port}}

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${{values.http_port}}/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]