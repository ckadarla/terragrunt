
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

       
        // stage('terraform Plan') {
        //     steps {
        //         script {
        //             // CD into deployment folder and run terraform commands
        //             dir("vpc/") {
        //                 sh 'terraform init'
        //                 sh 'terraform plan'
        //             }
        //         }
        //     }
        // }

        

        // stage('terraform Action') {
        //     steps {
        //         script {
        //             // CD into deployment folder and run terraform apply or destroy based on user input
        //             dir("vpc/") {
        //                 sh "terraform ${params.ACTION}  -auto-approve"
        //             }
        //         }
        //     }
        // }
        stage('Terraform Init EC2') {
            steps {
                script {
                    sh "cd ec2 && terraform init"
                    sh "terraform plan"
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    // Prompt for approval
                    input message: "Do you want to ${params.ACTION} terraform changes?", ok: "Yes, proceed with terraform ${params.ACTION}"
                }
            }
        }

        stage('Terraform Apply/Destroy EC2') {
            steps {
                script {
                    def terraformAction = params.ACTION.toLowerCase()
                    sh "cd ec2 && terraform ${terraformAction} -auto-approve"
                }
            }
        }
    }
}
