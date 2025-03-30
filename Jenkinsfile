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
                // ตรวจสอบว่า Docker พร้อมใช้งาน
                sh 'docker --version'  // สำหรับ Linux หรือ macOS
                // bat 'docker --version' // หากใช้ Windows
    
                // ตรวจสอบสถานะ Docker Daemon
                sh 'docker ps -a'  // สำหรับ Linux หรือ macOS
                // bat 'docker ps -a'  // หากใช้ Windows
    
                // สร้าง Docker Image
                sh 'docker build -t csi403-frontend .'  // ใช้ sh สำหรับ Linux หรือ macOS
                // bat 'docker build -t csi403-frontend .'  // หากใช้ Windows
    
                echo "Docker Build Image Success"
            }
    
            echo "Docker Image to Running Container"
            script {
                // ลบ container เก่าหากมี
                sh 'docker rm -f csi403-frontend-run || true'  // สำหรับ Linux หรือ macOS
                // bat 'docker rm -f csi403-frontend-run || true'  // หากใช้ Windows
    
                // รัน Docker container
                sh 'docker run -d --name csi403-frontend-run -p 54100:3000 csi403-frontend:latest'  // สำหรับ Linux หรือ macOS
                // bat 'docker run -d --name csi403-frontend-run -p 54100:3000 csi403-frontend:latest'  // หากใช้ Windows
    
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
