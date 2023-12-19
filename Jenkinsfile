pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Select Terraform Action')
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                // Pull the git repo
                cleanWs()
                checkout scm
            }
        }
        
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ckadarla/terragrunt.git'
            }
        }

        stage('Terraform Init VPC') {
            steps {
                script {
                    sh "cd vpc && ${TF_HOME}/terraform init"
                }
            }
        }

        stage('Terraform Apply/Destroy VPC') {
            steps {
                script {
                    def terraformAction = params.ACTION.toLowerCase()
                    sh "cd vpc && ${TF_HOME}/terraform ${terraformAction} -auto-approve"
                }
            }
        }

        stage('Terraform Init EC2') {
            steps {
                script {
                    sh "cd ec2 && ${TF_HOME}/terraform init"
                }
            }
        }

        stage('Terraform Apply/Destroy EC2') {
            steps {
                script {
                    def terraformAction = params.ACTION.toLowerCase()
                    sh "cd ec2 && ${TF_HOME}/terraform ${terraformAction} -auto-approve"
                }
            }
        }
    }

    post {
        always {
            // Clean up any temporary files or artifacts
            deleteDir()
        }
    }
}
