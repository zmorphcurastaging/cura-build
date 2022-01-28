pipeline {
    agent {
        docker {
            image 'alpine:latest'
            label 'master'
            args  '-v /tmp:/tmp'
        }
    }
    stages {
        stage('run_in_container') {
            steps {
                sh 'sudo ./docker/linux/build.sh'
            }
        }
    }
}
