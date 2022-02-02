pipeline {
    agent none

    environment{
        MY_FILE = fileExists './output'
    }

    stages {
/*
        stage ('test') {
            agent { label 'jworker' }
            steps{
                sh 'ls'
            }
        }
*/
        
        stage ('Clean environment') {
            agent { label 'jworker' }            
            when { expression { MY_FILE == 'true' } }
            steps {
                echo "file exists"
            }
        }

        stage('conditional if not exists'){
            agent { label 'jworker' }            
            when { expression { MY_FILE == 'false' } }
            steps {
                echo "file does not exist"
            }
        }
/*
        stage ('Run build') {
            agent { label 'jworker' }
            steps {
                sh 'sudo ./docker/linux/build.sh'
            }
        }
*/
    }
}