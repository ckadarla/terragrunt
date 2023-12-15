def installTerraform() {
    // Install Terragrunt
    def terragruntExists = sh(script: 'command -v terragrunt', returnStatus: true)
    if (terragruntExists != 0) {
        // Install terragrunt
        sh '''
            echo "Installing Terragrunt..."
            wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.35.0/terragrunt_linux_amd64
            chmod +x terragrunt_linux_amd64
            sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
        '''
    } else {
        echo "Terragrunt already installed!"
    }
}

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

        stage('Install Terraform and Terragrunt') {
            steps {
                script {
                    installTerraform()
                }
            }
        }

        stage('Terragrunt Plan') {
            steps {
                script {
                    // CD into deployment folder and run terragrunt commands
                    dir("vpc/") {
                        sh 'terragrunt init'
                        sh 'terragrunt plan'
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                script {
                    // Prompt for approval
                    input message: "Do you want to ${params.ACTION} Terragrunt changes?", ok: "Yes, proceed with Terragrunt ${params.ACTION}"
                }
            }
        }

        stage('Terragrunt Action') {
            steps {
                script {
                    // CD into deployment folder and run terragrunt apply or destroy based on user input
                    dir("vpc/") {
                        sh "terragrunt ${params.ACTION}  -auto-approve"
                    }
                }
            }
        }
    }
}
