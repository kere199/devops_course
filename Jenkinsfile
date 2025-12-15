pipeline {
    agent any

    tools {
        go "1.24.1"
    }

    environment {
        IMAGE = "ttl.sh/myapp-${BUILD_NUMBER}:1h"
    }

    stages {

        stage('Test') {
            steps {
                sh 'go test ./...'
            }
        }

        stage('Build') {
            steps {
                sh 'go build main.go'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE} .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push ${IMAGE}'
            }
        }

        stage('Deploy Pod to Kubernetes') {
            steps {
                withKubeConfig(
                    credentialsId: 'k8s-token',
                    serverUrl: 'https://kubernetes:6443'
                ) {
                    sh '''
                    kubectl delete pod myapp --ignore-not-found
                    kubectl run myapp \
                      --image=${IMAGE} \
                      --port=4444
                    '''
                }
            }
        }
    }
}
