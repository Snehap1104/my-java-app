pipeline {
    agent any

    environment {
        IMAGE_NAME = 'sneha2311/my-java-app'
        IMAGE_TAG = 'latest'
        DOCKERHUB_USERNAME = credentials('dockerhub-username') // Docker Hub username credential
        DOCKERHUB_PASSWORD = credentials('dockerhub-password') // Docker Hub password/access token
    }

    stages {
        // Stage 1: Clone the repository from GitHub
        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Snehap1104/my-java-app.git',
                    credentialsId: 'github-credentials' // GitHub PAT credentials ID
            }
        }

        // Stage 2: Build the Docker image
        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME%:%IMAGE_TAG% ."
            }
        }

        // Stage 3: Login to Docker Hub
        stage('Login to Docker Hub') {
            steps {
                bat """
                docker login -u %DOCKERHUB_USERNAME% -p %DOCKERHUB_PASSWORD%
                """
            }
        }

        // Stage 4: Push Docker Image to Docker Hub
        stage('Push Docker Image') {
            steps {
                bat "docker push %IMAGE_NAME%:%IMAGE_TAG%"
            }
        }
    }

    post {
        success {
            echo "Docker image ${IMAGE_NAME}:${IMAGE_TAG} pushed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
