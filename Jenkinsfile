pipeline {
    agent none
    environment{
    OTUPUT_EXIST = fileExists 'output'
    }
    stages {
        
        stage ('Clean environment') {
            agent { label 'jworker' }

            //check if file otuput exist and delete it if true
            when { expression { OTUPUT_EXIST == 'true' } }
            steps {
                sh 'sudo rm -r output'
            }
            
            steps {
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
