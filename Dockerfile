# Use the official .NET SDK image
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
