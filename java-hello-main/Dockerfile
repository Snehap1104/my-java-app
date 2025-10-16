# Use an official OpenJDK image
FROM openjdk:17

# Copy all files into the image
COPY . /app
WORKDIR /app

# Compile Java code
RUN javac Main.java

# Run the app
CMD ["java", "Main"]
    