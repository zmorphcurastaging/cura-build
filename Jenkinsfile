pipeline {
    agent {
        docker {
            image 'alpine:latest'
            label 'master'
            args  '-v /tmp:/tmp'
        }
    }
    stages {
        stage('01') {
            steps {
                sh "echo STAGE01"
            }
        }
        stage('02') {
            steps {
                sh "echo STAGE02"
            }
        }
    }
}
