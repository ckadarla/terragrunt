
pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select Terraform action: apply or destroy')
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Pull the git repo
                cleanWs()
                checkout scm
            }
        }

              
        stage('terraform Plan') {
            steps {
                script {
                    // CD into deployment folder and run terraform commands
                    dir("ec2/") {
                        sh 'terraform init'
                        sh 'terraform plan'
                    }
                }
            }
        }

        // stage('Approval') {
        //     steps {
        //         script {
        //             // Prompt for approval
        //             input message: "Do you want to ${params.ACTION} terraform changes?", ok: "Yes, proceed with terraform ${params.ACTION}"
        //         }
        //     }
        // }

        stage('Terraform Apply') {
            steps {
                script {
                    // Run 'terraform apply' to create/update resources
                    // Requires manual approval before proceeding
                    echo "\u001B[33mApproval: Do you want to apply the Terraform changes?\u001B[0m"  // Yellow color
                    input 'Proceed with the Terraform apply?'
                    echo "\u001B[32mTerraform Apply...\u001B[31m"  // Blue color
                    // sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('terraform Action') {
            steps {
                script {
                    // CD into deployment folder and run terraform apply or destroy based on user input
                    dir("ec2/") {
                        sh "terraform ${params.ACTION}  -auto-approve"
                    }
                }
            }
        }
        
    }
}
