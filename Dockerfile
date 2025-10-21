# Use OpenJDK base image
FROM openjdk:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy Java source file
COPY app/HelloWorldApp.java .

# Compile Java program
RUN javac HelloWorldApp.java

# Command to run the application
CMD ["java", "HelloWorldApp"]
