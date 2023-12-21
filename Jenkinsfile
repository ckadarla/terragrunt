pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action: apply or destroy')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging'], description: 'Select environment: dev or staging')
        choice(name: 'component', choices: ['vpc', 'eks'], description: 'Select component: VPC or EKS')
    }

    stages {
        
        stage('Terragrunt Init ') {
            steps {
                script {
                    dir("eks/${params.ENVIRONMENT}/${params.component}") {
                        sh "terragrunt init"
                    }
                }
            }
        }

        stage('Terragrunt Plan') {
            steps {
                script {
                    dir("eks/${params.ENVIRONMENT}/${params.component}") {
                        sh "terragrunt plan"
                    }
                }
            }
        }

        // stage('Manual Approval') {
        //     steps {
        //         script {
        //             // Request manual input for approval
        //             input "Do you want to proceed with ${params.ACTION} in ${params.ENVIRONMENT} environment?"
        //         }
        //     }
        // }

        stage('Terragrunt Action') {
            steps {
                script {
                    dir("eks/${params.ENVIRONMENT}/${params.component}") {
                        sh "terragrunt ${params.ACTION} --auto-approve"
                    }
                }
            }
        }

        stage('Clean Code') {
            steps {
                cleanWs()
            }
        }
    }
}
