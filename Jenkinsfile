pipeline {
    agent none
    stages {
        
        stage ('Clean environment') {
            agent { label 'jworker' }
            steps {
                sh 'if [[ -d output ]] \
                    then \
                    sudo rm -r output \
                    fi'
                sh 'docker stop cura-build'
                sh 'docker rm cura-build'
                sh 'docker image rm 8b25c9f4b47a'
            }
        }

        stage ('Run build') {
            agent { label 'jworker' }
            steps {
                sh 'sudo ./docker/linux/build.sh'
            }
        }

    }
}
