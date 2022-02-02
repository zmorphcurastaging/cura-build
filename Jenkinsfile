pipeline {
    agent none

    stages {
        
        stage ('Clean environment') {
            when { expression { return fileExists ('./output') } }
            steps {
                sh 'sudo rm -r ./output'
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