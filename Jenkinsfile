pipeline {
    agent any

    environment {
        // Docker Hub credentials stored in Jenkins
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME = 'sneha2311/my-java-app'
        IMAGE_TAG = 'latest'
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
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        // Stage 3: Login to Docker Hub
        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        echo "Logged in to Docker Hub"
                    }
                }
            }
        }

        // Stage 4: Push Docker Image to Docker Hub
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }
    }

    // Post actions
    post {
        success {
            echo "Docker image ${IMAGE_NAME}:${IMAGE_TAG} pushed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
