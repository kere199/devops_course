pipeline {
    agent any

    tools {
       go "1.25"
    }

    stages {
        stage('Build') {
            steps {
                sh "go build main.go"
            }
        }
    }
}