pipeline {
    agent none

    stages {

        stage ('Run build') {
            agent { label 'jworker' }

            steps {
                docker.image('alpine:3.7').inside {
                    sh 'sudo ./docker/linux/build.sh'
                }
            }
        }
    }
}
