# Stage 1: Build the Angular app
FROM node:18 as build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the Angular CLI
RUN npm install -g @angular/cli

# Install project dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Build the Angular application with the production flag
RUN ng build --prod

# Stage 2: Create a smaller image for serving the app
FROM nginx:alpine

# Copy the built Angular app to the nginx directory
COPY --from=build /app/dist/ /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the nginx web server
CMD ["nginx", "-g", "daemon off;"]
