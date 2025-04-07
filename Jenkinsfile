pipeline {
    agent any

    stages {
        // Stage to check out the repository
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Dotnet122/testingci_cd.git', branch: 'main'
            }
        }

        // Stage to verify the working directory and list files
        stage('Verify Directory') {
            steps {
                script {
                    // Print the current directory and list the files in the workspace
                    bat 'echo Current directory: %cd%'
                    bat 'dir'  // List files to confirm the solution file is present
                }
            }
        }

        // Stage to restore dependencies
        stage('Restore Dependencies') {
            steps {
                script {
                    // Run the restore command
                    bat 'dotnet restore WebApplication2.sln'
                }
            }
        }

        // Optional: Build stage (you can add build steps here if needed)
        stage('Build') {
            steps {
                script {
                    // Example: Build the solution
                    bat 'dotnet build WebApplication2.sln'
                }
            }
        }

        // Optional: Test stage (you can add testing steps here if needed)
        stage('Test') {
            steps {
                script {
                    // Example: Run tests (if applicable)
                    bat 'dotnet test WebApplication2.sln'
                }
            }
        }

        // Optional: Publish stage (you can add publishing steps here if needed)
        stage('Publish') {
            steps {
                script {
                    // Example: Publish the app (adjust based on your requirements)
                    bat 'dotnet publish WebApplication2.sln -c Release'
                }
            }
        }
    }

    // Post actions (optional, add any cleanup or notification steps here)
    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
