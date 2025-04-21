# Dockerfile
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source code
COPY . .

# Build admin panel
RUN npm run build

# Expose app port
EXPOSE 1337

# Start the app
CMD ["npm", "start"]
