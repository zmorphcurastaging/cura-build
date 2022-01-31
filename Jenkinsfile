pipeline {
    agent {
        docker {
            image 'ubuntu:latest'
            label 'jworker'
            args  '-v $HOME/:/srv/'
        }
    }
    stages {
        stage('run_in_container') {
            steps {
                sh 'git clone https://github.com/zmorph/cura-build.git'
                sh 'sudo docker/linux/build.sh'
            }
        }
    }
}
