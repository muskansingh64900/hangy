# Stage 1: Build Flutter Web
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

# Copy pubspec files first for caching
COPY frontend/hangpoint_app/pubspec.yaml frontend/hangpoint_app/pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy rest of the Flutter project
COPY frontend/hangpoint_app/ .

# Build for web
RUN flutter build web --release

# Stage 2: Serve with Nginx
FROM nginx:alpine AS runtime

# Copy built web files
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
