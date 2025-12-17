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
                        mkdir -p ~/app &&
                        pkill myapp || true
                    "
                    '''

                    sh '''
                    scp -o StrictHostKeyChecking=no -i $KEY myapp $USER@43.209.9.28:~/app/
                    '''

                    sh '''
                    ssh -o StrictHostKeyChecking=no -i $KEY $USER@43.209.9.28 "
                        chmod +x ~/app/myapp &&
                        nohup ~/app/myapp > ~/app/app.log 2>&1 </dev/null >/dev/null 2>&1 &
                        exit
                    "
                    '''
                }
            }
        }
    }
}
