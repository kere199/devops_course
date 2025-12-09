pipeline {
    agent any
    tools {
        go "1.24.1"
    }
    environment {
        IMAGE = "ttl.sh/myapp-${BUILD_NUMBER}:2h"
        CONTAINER_NAME = "myapp"
    }
    stages {
        stage('Test') {
            steps {
                sh "go test ./..."
            }
        }
        stage('Docker Build & Push') {
            steps {
                echo "Building Docker image ${IMAGE}"
                sh "docker build -t ${IMAGE} ."
                sh "docker push ${IMAGE}"
            }
        }
        stage('Deploy to Docker VM') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'KEYFILE', usernameVariable: 'USERNAME')]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no -i ${KEYFILE} ${USERNAME}@172.16.0.3 '
                        docker pull ${IMAGE}
                        docker stop ${CONTAINER_NAME} || true
                        docker rm ${CONTAINER_NAME} || true
                        docker run -d --name ${CONTAINER_NAME} -p 4444:4444 ${IMAGE}
                    '
                    """
                }
            }
        }
    }
}
