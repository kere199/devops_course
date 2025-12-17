pipeline {
    agent any

    tools {
        go "1.24.1"
    }

    stages {
        stage('Test') {
            steps {
                sh 'go test ./...'
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
                        keyFileVariable: 'KEY',
                        usernameVariable: 'USER'
                    )
                ]) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no -i $KEY $USER@43.209.9.28 "
                        mkdir -p ~/app
                    "
                    '''

                    sh '''
                    scp -o StrictHostKeyChecking=no -i $KEY myapp $USER@43.209.9.28:~/app/
                    '''
                }
            }
        }
    }
}
