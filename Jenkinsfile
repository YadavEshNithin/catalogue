pipeline {
    agent {
        label "AGENT-1"
    }
    environment {
        // COURSE = "JENKINS"
        appVersion = ""
        REGION="us-east-1"
        ACC_ID="010666226306"
        PROJECT="roboshop"
        COMPONENT="catalogue"
    }
    options {
        timeout(time: 30, unit: 'MINUTES') 
        disableConcurrentBuilds()
    }
    // parameters {
    //     // string(name: 'PERSON', defaultValue: 'Mr Jenkins NEW', description: 'Who should I say hello to?')
    //     // text(name: 'BIOGRAPHY', defaultValue: 'JB', description: 'Enter some information about the person')
    //     // booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
    //     // choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
    //     // password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password') 
    // }
    stages {
        stage('Read package.json') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "Application Version: ${appVersion}"
                }
            }
        }
        stage('install dependencies') {
            steps {
                script {
                    sh """
                        npm install
                    """
                }    
            }
        }
        stage('Docker build') {
            steps {
                withAWS(credentials: 'aws-credds', region: 'us-east-1') {
                sh """
                    aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t ${PROJECT}/${COMPONENT}:${appVersion} .
                    docker push ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                """
            }
            }
            
        }
        stage('Deploy') {
            // input {
            //     message "Should we continue?"
            //     ok "Yes, we should."
            //     submitter "alice,bob"
            //     parameters {
            //         string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
            //     }
            // }
            steps {
                echo 'Deploying....'
                // echo "Hello, ${PERSON}, nice to meet you."
            }
        }
    }


    post {
        always {
            echo " always hello"
            deleteDir()
        }
        success {
            echo " success hello"
        }
        failure {
            echo " failure hello"
        }
    }
}