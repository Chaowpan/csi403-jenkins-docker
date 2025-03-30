pipeline {
    agent any
    stages {
        stage('Check Out') {
            steps {
                echo "Check Out"
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [
                        [ 
                            credentialsId: 'Chaowpan', 
                            url: 'https://github.com/Chaowpan/csi403-jenkins-docker.git'
                        ]
                    ]
                ])
                echo "Clone Success"
            }
        }

        stage('Build') {
            steps {
                echo "Docker Build Image"
                script {
                    bat "docker build -t csi403-frontend ."
                    echo "Docker Build Image Success"
                }

                echo "Docker Image to Running Container"
                script {
                    bat "docker rm -f csi403-frontend-run || true"
                    bat "docker run -d --name csi403-frontend-run -p 54100:3000 csi403-frontend:latest"
                    echo "Docker Image to Running Container Success"
                }
            }
        }

        stage('Test') {
            steps {
                echo "Install Robot Framework and Dependencies"
                script {
                    // ติดตั้ง Robot Framework และ dependencies
                    bat "pip install -r requirements.txt"
                }
                echo "Run Robot Framework Tests"
                script {
                    // รันไฟล์ทดสอบ Robot Framework
                    bat "robot tests/test_file.robot"  // แทนที่ 'tests/test_file.robot' กับไฟล์ทดสอบของคุณ
                }
                echo "Testing Completed"
            }
        }
    }
}
