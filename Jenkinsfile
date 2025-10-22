pipeline {
    agent any
    
    environment {
        // Docker Hub credentials (configure in Jenkins)
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-newcreds')
        DOCKER_HUB_USERNAME = 'sneha2311'
        IMAGE_NAME = 'my-java-app'
        IMAGE_TAG = "${BUILD_NUMBER}"
        FULL_IMAGE_NAME = "${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
        LATEST_IMAGE_NAME = "${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${FULL_IMAGE_NAME}"
                    sh """
                        docker build -t ${FULL_IMAGE_NAME} .
                        docker tag ${FULL_IMAGE_NAME} ${LATEST_IMAGE_NAME}
                    """
                }
            }
        }
        
        stage('Test Image') {
            steps {
                script {
                    echo 'Testing Docker image...'
                    sh """
                        docker run --rm ${FULL_IMAGE_NAME} java -version
                    """
                }
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                script {
                    echo 'Logging into Docker Hub...'
                    sh """
                        echo \$DOCKER_HUB_CREDENTIALS_PSW | docker login -u \$DOCKER_HUB_CREDENTIALS_USR --password-stdin
                    """
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Pushing image to Docker Hub..."
                    sh """
                        docker push ${FULL_IMAGE_NAME}
                        docker push ${LATEST_IMAGE_NAME}
                    """
                }
            }
        }
        
        stage('Cleanup') {
            steps {
                script {
                    echo 'Cleaning up local images...'
                    sh """
                        docker rmi ${FULL_IMAGE_NAME} || true
                        docker rmi ${LATEST_IMAGE_NAME} || true
                    """
                }
            }
        }
    }
    
    post {
        success {
            echo "Pipeline completed successfully!"
            echo "Image pushed: ${FULL_IMAGE_NAME}"
            echo "Image pushed: ${LATEST_IMAGE_NAME}"
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            script {
                sh 'docker logout || true'
            }
        }
    }
}
