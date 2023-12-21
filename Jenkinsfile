pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action: apply or destroy')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging'], description: 'Select environment: dev or staging')
        choice(name: 'component', choices: ['vpc', 'eks'], description: 'Select component: VPC or EKS')
    }

    stages {
        // stage('Checkout Code') {
        //     steps {
        //         // Pull the git repo
        //         cleanWs()
        //         checkout scm
        //     }
        // }

        stage('Terragrunt Init & plan') {
            steps {
                script {
                    dir("eks/${params.ENVIRONMENT}/${params.component}") {
                        // Assuming you have a terragrunt.hcl file in your environment folder
                        sh "terragrunt  init && terragrunt plan"
                    }
                }
            }
        }

        // stage('Approval') {
        //     steps {
        //         script {
        //             // Prompt for approval
        //             input message: "Do you want to ${params.ACTION} Terragrunt changes?", ok: "Yes, proceed with Terragrunt ${params.ACTION}"
        //         }
        //     }
        // }
        
        stage('Terragrunt Action') {
            steps {
                script {
                    dir("eks/${params.ENVIRONMENT}/${params.component}") {
                        // Assuming you have a terragrunt.hcl file in your environment folder
                        sh "terragrunt  ${params.ACTION} --auto-approve"
                    }
                }
            }
        }
    }
}
