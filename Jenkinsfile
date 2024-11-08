pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository from GitHub
                git 'https://github.com/Viswaraje/frontend-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the multi-stage Dockerfile
                    bat 'docker build -t frontend-image .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Authenticate with DockerHub (add your Docker credentials to Jenkins)
                    withDockerRegistry([credentialsId: 'docker-viswaraje', url: 'https://index.docker.io/v1/']) {
                        // Push the Docker image to DockerHub
                        bat 'docker push frontend-image'
                    }
                }
            }
        }

        stage('Deploy to Container') {
            steps {
                script {
                    // Run the Docker container and expose port 80
                    bat 'docker run -d -p 80:80 frontend-image'
                }
            }
        }
    }

    post {
        always {
            // Clean up the workspace after the pipeline is complete
            cleanWs()
        }
    }
}
