pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'stripe-server'          // Replace with your Docker image name
        DOCKER_CREDENTIALS_ID = 'realestate1234' // Jenkins Docker Hub credentials ID
    }

    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    // Install dependencies to ensure everything is set up correctly
                    sh 'npm install'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:latest ."
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        sh "docker tag ${DOCKER_IMAGE}:latest ${DOCKER_IMAGE}:latest"
                        sh "docker push ${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed successfully.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
