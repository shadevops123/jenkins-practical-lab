
pipeline {
    agent any

    parameters {
        string(
            name: 'APP_VERSION',
            defaultValue: '1.0.0',
            description: 'Application version to build'
        )

        choice(
            name: 'DEPLOY_ENV',
            choices: ['dev', 'staging', 'production'],
            description: 'Target environment'
        )

        booleanParam(
            name: 'RUN_TESTS',
            defaultValue: true,
            description: 'Run application tests'
        )
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo 'Source code checked out successfully'
            }
        }

        stage('Build') {
            steps {
                echo "Building version: ${params.APP_VERSION}"
                echo "Target environment: ${params.DEPLOY_ENV}"

                sh '''
                    mkdir -p output
                    echo "$APP_VERSION" > output/version.txt
                    echo "Environment: $DEPLOY_ENV" >> output/version.txt
                '''
            }
        }

        stage('Test') {
            when {
                expression { params.RUN_TESTS }
            }
            steps {
                sh 'bash test.sh'
            }
        }

        stage('Package') {
            steps {
                archiveArtifacts artifacts: 'output/*',
                                 fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check Console Output.'
        }
    }
}

   
