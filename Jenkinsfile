pipeline {
    agent none

    stages {

        stage ('Run build') {
            agent { label 'jworker' }
               docker { image 'ubuntu:latest' }
        }
    }
}
