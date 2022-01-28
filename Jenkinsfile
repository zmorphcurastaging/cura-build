pipeline {
    agent none

    stages {

        stage ('Run build') {
            agent { label 'jworker' }

            steps {
                sudo sh './docker/linux/build.sh'
            }
        }
    }
}
