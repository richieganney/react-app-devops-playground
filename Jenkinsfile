pipeline {
    agent any
    tools {
        nodejs "nodejs"
        terraform "terraform"
    }
    stages {
        stage("Build") {
            steps {
                script {
                    sh """
                    npm install
                    npm run build
                    """
                }
            }
        }
        stage("Test") {
            steps {
                script {
                    sh script: "npm test", returnStatus: true
                }
            }
        }
        stage("Deploy") {
            steps {
                script {
                    sh """
                    zip -r $UNIQUE_ANIMAL_IDENTIFIER-build-artifacts.zip build/
                    aws s3 cp $UNIQUE_ANIMAL_IDENTIFIER-build-artifacts.zip s3://dpg-november-artifact-bucket
                    cd terraform
                    terraform init -backend-config="key=${UNIQUE_ANIMAL_IDENTIFIER}.tfstate"
                    terraform apply --auto-approve
                    """
                }
            }
        }
        stage("Show Domain") {
            steps {
                script {
                    sh script: "bash ${WORKSPACE}/scripts/display-dns.sh ${UNIQUE_ANIMAL_IDENTIFIER}", returnStatus: true
                }
            }
        }
    }
    post {
        cleanup {
            deleteDir()
        }
    }
}