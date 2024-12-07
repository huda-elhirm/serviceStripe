pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'realestate1234/stripe-server'          // Replace with your Docker image name
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Jenkins Docker Hub credentials ID
        KUBECONFIG_CREDENTIALS_ID = 'kube-config' // Kubernetes credentials ID in Jenkins
        K8S_DEPLOYMENT_FILE = 'stripe-deply.yml' // Path to your Kubernetes deployment file
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
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                        sh "kubectl --kubeconfig=$KUBECONFIG apply -f ${K8S_DEPLOYMENT_FILE}"
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
