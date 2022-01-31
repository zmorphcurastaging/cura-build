pipeline {
    agent {
        docker {
            image 'ubuntu:latest'
            label 'jworker'
            //args  '-v /tmp:/tmp'
        }
    }
    stages {
        stage('run_in_container') {
            steps {
                sh 'git clone https://github.com/zmorph/cura-build.git /tmp'
                sh 'sudo /tmp/cura-build/docker/linux/build.sh'
            }
        }
    }
}
