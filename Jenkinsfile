pipeline {
    agent any

    tools {
       go "1.24.1"
    }

    stages {
        stage('Test') {
              steps {
                   sh "go test ./..."
              }
        }
        stage('Build') {
            steps {
                sh "go build main.go"
            }
        }
        stage('Deploy') {
          steps {
              withCredentials([sshUserPrivateKey(credentialsId: '9bf4e59b-0817-408b-9616-8301b9395824', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                sh 'scp -o StrictHostKeyChecking=no -i ${FILENAME} main ${USERNAME}@target:'
            }
          }
        }
    }
}