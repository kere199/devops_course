// pipeline {
//     agent any

//     environment {
//         IMAGE_NAME = "ttl.sh/myapp:${BUILD_NUMBER}" 
//         CONTAINER_NAME = "myapp-container"
//     }

//     stages {
//         stage('Test') {
//             steps {
//                 echo "Running tests..."
//             }
//         }
        
//         stage('Build') {
//             steps {
//                 echo "Skipping direct 'go build', it will be done in the Docker image stage."
//             }
//         }

//         stage('Docker Build & Push') {
//             steps {
//                 sh "docker build -t ${IMAGE_NAME} ."
//                 sh "docker push ${IMAGE_NAME}"
//                 echo "Docker image ${IMAGE_NAME} built and pushed."
//             }
//         }

//         stage('Deploy') {
//             steps {
//                 withCredentials([sshUserPrivateKey(
//                     credentialsId: 'mykey',  
//                     keyFileVariable: 'KEYFILE',  
//                     usernameVariable: 'USERNAME'
//                 )]) {
//                     sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} ${USERNAME}@target "docker stop ${CONTAINER_NAME} || true"'
//                     sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} ${USERNAME}@target "docker rm ${CONTAINER_NAME} || true"'
                    
//                     sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} ${USERNAME}@target "docker pull ${IMAGE_NAME}"'
//                     sh 'ssh -o StrictHostKeyChecking=no -i ${KEYFILE} ${USERNAME}@target "docker run -d --name ${CONTAINER_NAME} -p 4444:4444 ${IMAGE_NAME}"'
                    
//                     echo "Application deployed as container ${CONTAINER_NAME} using image ${IMAGE_NAME}."
//                 }
//             }
//         }
//     }
// }

pipeline {
    agent any
    
    environment {
        IMAGE_NAME = "ttl.sh/myapp-${BUILD_NUMBER}:1h" 
        CONTAINER_NAME = "myapp-container" 
    }

    stages {
        stage('Test') {
            steps {
                echo "Running tests..."
                // You can optionally run your Go tests here
                // sh "go test ./..."
            }
        }
        
        stage('Build') {
            steps {
                echo "Skipping direct 'go build', it will be done in the Docker image stage."
            }
        }

        stage('Docker Build & Push') {
            steps {
                echo "Building Docker image ${IMAGE_NAME}..."
                sh "docker build -t ${IMAGE_NAME} ."
                
                echo "Pushing Docker image to ttl.sh..."
                sh "docker push ${IMAGE_NAME}"
                
                echo "Docker image ${IMAGE_NAME} built and pushed to ttl.sh successfully."
            }
        }
    }
}
