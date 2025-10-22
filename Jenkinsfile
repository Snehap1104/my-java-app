pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-newcreds'   // Jenkins credentials ID
        DOCKERHUB_USERNAME = 'sneha2311'               // your DockerHub username
        IMAGE_NAME = 'my-java-app'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: 'https://github.com/Snehap1104/my-java-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def fullImageName = "${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
                    echo "Building Docker image: ${fullImageName}"
                    // Use PowerShell-friendly command
                    bat """
                        docker build -t ${fullImageName} .
                    """
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: "${DOCKERHUB_CREDENTIALS}",
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS')]) {
                        echo "Logging into Docker Hub..."
                        bat """
                            echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        """
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def fullImageName = "${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
                    echo "Pushing Docker image: ${fullImageName}"
                    bat """
                        docker push ${fullImageName}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Docker image pushed successfully: ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
        }
        failure {
            echo "❌ Pipeline failed. Check Jenkins console output for errors."
        }
    }
}
