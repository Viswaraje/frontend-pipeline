# Stage 1: Build the React application
FROM node:16 AS build-stage

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Run tests (optional, depending on your project setup)
RUN npm test -- --coverage

# Build the React application for production
RUN npm run build

# Stage 2: Serve the production build
FROM nginx:alpine AS production-stage

# Copy the build files from the first stage to the nginx folder
COPY --from=build-stage /app/build /usr/share/nginx/html

# Expose port 80 for the web application
EXPOSE 80

# Start nginx server to serve the app
CMD ["nginx", "-g", "daemon off;"]
