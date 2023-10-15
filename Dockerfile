# Use an official Node.js runtime as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install project dependencies
RUN npm install

# Copy the entire Angular application code into the working directory
COPY . .

# Build the Angular application
RUN ng build --prod

# Expose the default Angular port
EXPOSE 4200

# Start the Angular application
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
