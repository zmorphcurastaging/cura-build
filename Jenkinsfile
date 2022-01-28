pipeline {
    agent none

    stages {

        stage ('Hello') {
            agent { label 'jworker' }

            steps {
                echo 'Hello, '

                sh '''#!/bin/bash

                    echo "Hello from bash"
                    echo "Who I'm $SHELL"
                '''
            }
        }
    }
}
