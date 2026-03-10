# Use Debian-based image so Rollup's optional linux-x64-gnu binary installs correctly
# (Alpine/musl has a known npm bug with optional deps: @rollup/rollup-linux-x64-musl)
FROM node:18-bookworm-slim

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (native Rollup binary for linux-x64-gnu)
RUN npm install

# Copy the rest of the application
COPY . .

# Expose port
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--host"]