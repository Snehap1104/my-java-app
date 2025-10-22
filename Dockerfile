# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml first (for better caching)
COPY app/pom.xml .

# Download dependencies (cached if pom.xml doesn't change)
RUN mvn dependency:go-offline

# Copy source code
COPY app/App.java ./src/main/java/

# Package the application
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR file from build stage
COPY --from=build /app/target/hello-world-app.jar app.jar

# Add metadata
LABEL description="Java Hello World Application"
LABEL version="1.0.0"

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
