pipeline {
    agent any

    environment{
        old_files = fileExists './output'
        old_containers = sh (script: 'docker ps -a -f name=cura-build-environment | wc -l', , returnStdout:true).trim()
    }

    stages {
/*        
        stage ('Clean environment files') {            

            when { expression { old_files == 'true' } }
            steps {
                sh 'sudo rm -r ./output'
                echo old_containers
            }
        }

        stage ('Clean environment docker') {            

            when { expression { old_containers == "2" } }
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
*/
        stage ('Signing') {
            steps {
                script {
                    appname = sh(script: 'ls ./output/appimages/ |grep AppImage', returnStdout: true );
                }
                
                //sh 'sudo gpg --detach-sig --armor ./output/appimages/Ultimaker_Cura-*.AppImage'
                //sh 'sudo gpg --export -a --output ./output/appimages/public_key.asc'
                sh 'sudo sha1sum ${appname} > ${appname}.sha1'
            }
        }

    }
    /*
    post {
        always {
            archiveArtifacts artifacts: 'output/build/', fingerprint: true
            //junit 'output/build/package/usr/bin/lib/test/xmltestdata/c14n-20/*.xml'
        }
    }
    */
}