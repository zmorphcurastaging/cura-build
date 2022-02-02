pipeline {
    agent none

    stages {
        
        stage ('Clean environment') {
            //when { expression { return fileExists ('output') } }
            steps {
                dir("output")
                if(!fileExists("./output"))
                {
                  //bat "mkdir \"C:/_Tests\""
                  echo "file exist"
                }
                //sh 'sudo rm -r ./output'
                //echo "file exist"
            }

        }

        //stage ('Run build') {
        //    agent { label 'jworker' }
        //    steps {
        //        sh 'sudo ./docker/linux/build.sh'
        //    }
        //}

    }
}