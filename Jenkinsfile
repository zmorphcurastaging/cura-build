pipeline {
    agent any

    environment{
        old_files = fileExists './output'
        old_containers = sh (script: 'docker ps -a', , returnStdout:true).trim()
    }

    stages {
        
        stage ('Clean environment files') {            

            when { expression { old_files == 'true' } }
            steps {
                sh 'sudo rm -r ./output'
                echo old_containers
            }
        }

        stage ('Clean environment docker') {            

            when { expression { old_containers != 'null' } }
            steps {
                sh 'docker stop cura-build-environment'
                sh 'docker rm cura-build-environment'
                sh 'docker image rm 8b25c9f4b47a'
            }
        }    

        stage ('Run build') {
            steps {
                sh 'sudo ./docker/linux/build.sh'
            }
        }

    }

    post {
        always {
            archiveArtifacts artifacts: 'build/libs/**/*.jar', fingerprint: true
            junit 'build/reports/**/*.xml'
        }
    }
}