# =========================
# Build stage
# =========================
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Copy dependency manifests first (better Docker layer caching)
COPY package.json package-lock.json ./

# Install dependencies (deterministic, CI-friendly)
RUN npm ci --no-audit --no-fund

# Copy the rest of the application source
COPY . .

# Build the Vite app (outputs to /app/dist)
RUN npm run build

# =========================
# Runtime stage
# =========================
FROM nginx:alpine

# Remove default nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy built frontend from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
