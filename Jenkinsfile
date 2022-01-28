pipeline {
    agent {
        docker {
            image 'ubuntu:latest'
            label 'jworker'
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
