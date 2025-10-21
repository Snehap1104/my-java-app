pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials' // Add in Jenkins credentials
        DOCKERHUB_USERNAME = 'sneha2311'
        IMAGE_NAME = 'my-java-app'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/yourusername/my-java-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image("${IMAGE_NAME}:latest").push()
                    }
                }
            }
        }
    }
}
