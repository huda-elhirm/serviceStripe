# Use Node.js as the base image
FROM node:16

# Set the working directory
WORKDIR /app

# Copy the package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app's files
COPY . .

# Expose the port that the app uses
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev"]
