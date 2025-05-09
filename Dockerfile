# Use the official Node.js image as the base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Enable polling for file changes
ENV CHOKIDAR_USEPOLLING=true

# Expose the port the app runs on
EXPOSE 8080

# Start the development server
CMD ["npm", "run", "dev"]