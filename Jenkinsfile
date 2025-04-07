pipeline {
    agent any

    environment {
        DOTNET_CLI_HOME = 'C:\\temp'  // Use a valid path for Windows
    }


    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Dotnet122/testingci_cd.git', branch: 'main'
            }
        }
 
        stage('Restore Dependencies') {
            steps {
                script {
                    // Restore NuGet packages for the solution
                    bat 'dotnet restore WebApplication_2.sln'
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build the solution in Release mode
                    bat 'dotnet build WebApplication_2.sln -c Release'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Run unit tests
                    bat 'dotnet test WebApplication_2.sln'
                }
            }
        }
        stage('Publish') {
            steps {
                script {
                    // Publish the application to a folder
                    bat 'dotnet publish WebApplication_2.sln -c Release -o C:\\path\\to\\output\\directory'
                }
            }
        }
    }
}
