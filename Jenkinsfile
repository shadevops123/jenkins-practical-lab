pipeline {
    agent any

    options {
        timestamps()
        timeout(time: 10, unit: 'MINUTES')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out source code"
                checkout scm
                sh 'git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                sh '''
                    echo "Building application..."
                    test -f index.html
                    mkdir -p output
                    cp index.html output/
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'bash test.sh'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'output/index.html',
                                 fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}
