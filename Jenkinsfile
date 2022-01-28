pipeline {
    agent none

    stages {

        stage ('Run build') {
            agent { label 'jworker' }
                steps {
                     docker { image 'ubuntu:latest' }
                 }
        }
    }
}
