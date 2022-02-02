pipeline {
    agent none

    stages {
        
        stage ('Clean environment') {
            agent { label 'jworker' }

            steps {
                //check if file otuput exist and delete it if true
                if (fileExists('file')) {
                    sh 'sudo rm -r output'
                }
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
