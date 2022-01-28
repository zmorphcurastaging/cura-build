pipeline {
    agent none

    stages {

        stage ('Run build') {
            agent { label 'jworker' }

            steps {
                docker.image("cura-build").inside(){sh 'sudo ./docker/linux/build.sh'}
            }
        }
    }
}
