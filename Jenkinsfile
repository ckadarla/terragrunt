pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action: apply or destroy')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging'], description: 'Select environment: dev or staging')
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pull the git repo
                cleanWs()
                checkout scm
            }
        }

        stage('Terragrunt Action') {
            steps {
                script {
                    dir("$eks/{params.ENVIRONMENT}/vpc") {
                        // Assuming you have a terragrunt.hcl file in your environment folder
                        sh "terragrunt runn-all init --terragrunt-exclude-dir kubernetes-addons"
                    }
                }
            }
        }

        stage('Terragrunt Action') {
            steps {
                script {
                    dir("$eks/{params.ENVIRONMENT}/vpc") {
                        // Assuming you have a terragrunt.hcl file in your environment folder
                        sh "terragrunt runn-all ${params.ACTION} --terragrunt-exclude-dir kubernetes-addons"
                    }
                }
            }
        }
    }
}
