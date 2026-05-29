# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY HangPoint.sln ./
COPY backend/HangPoint.API/HangPoint.API.csproj backend/HangPoint.API/
COPY backend/HangPoint.Tests/HangPoint.Tests.csproj backend/HangPoint.Tests/

# Restore dependencies
RUN dotnet restore

# Copy everything else
COPY backend/ backend/

# Build and publish
WORKDIR /src/backend/HangPoint.API
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 5166

ENTRYPOINT ["dotnet", "HangPoint.API.dll"]
