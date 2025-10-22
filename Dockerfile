# Use official Maven image to build the app
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy the pom.xml and Java files
COPY app/pom.xml .
COPY app/src ./src
COPY app/App.java ./src/main/java/

# Package the application
RUN mvn clean package -DskipTests

# Use lightweight JDK image to run the app
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port (change if needed)
EXPOSE 8080

# Run the Java application
ENTRYPOINT ["java", "-jar", "app.jar"]
