pipeline {
    agent any

    stages {
        // Stage to check out the repository
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Dotnet122/testingci_cd.git', branch: 'main'
            }
        }# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

# Copy everything to the container
COPY . .

# Restore dependencies
RUN dotnet restore WebApplication2.sln

# Publish the application
RUN dotnet publish WebApplication2.sln -c Release -o /app/publish

# Final stage: build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app

# Copy the published files from the previous stage
COPY --from=build /app/publish .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "WebApplication2.dll"]
pipeline {
    agent any

    environment {
        // Define your Docker image name here
        DOCKER_IMAGE_NAME = 'johndoe/webapplication2-image:latest'  // Replace with your image name
        DOCKER_REGISTRY = 'docker.io' // Default Docker Hub registry (replace with private registry if needed)
    }

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

        // New stage to build Docker image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    bat "docker build -t ${DOCKER_IMAGE_NAME} ."
                }
            }
        }

        // New stage to push Docker image to registry
        stage('Push Docker Image') {
            steps {
                script {
                    // Use Jenkins credentials to log in to Docker Hub (or your private registry)
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        
                        // Log in to Docker (this uses the credentials retrieved from Jenkins)
                        bat "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} ${DOCKER_REGISTRY}"

                        // Push the Docker image to the registry
                        bat "docker push ${DOCKER_IMAGE_NAME}"
                    }
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
