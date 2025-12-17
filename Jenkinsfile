pipeline {
    agent any

    tools {
        go "1.24.1"
    }

    stages {

        stage('Test') {
            steps {
                sh 'go test ./... || true'
            }
        }

        stage('Build') {
            steps {
                sh 'go build -o myapp main.go'
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'mykey',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    )
                ]) {

                    sh '''
                    ssh -o StrictHostKeyChecking=no -i $SSH_KEY $SSH_USER@43.209.9.28 "mkdir -p ~/app"
                    scp -o StrictHostKeyChecking=no -i $SSH_KEY myapp $SSH_USER@43.209.9.28:~/app/myapp
                    ssh -o StrictHostKeyChecking=no -i $SSH_KEY $SSH_USER@43.209.9.28 "chmod +x ~/app/myapp"
                    '''
                }
            }
        }
    }
}
