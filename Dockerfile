## BUILD PHASE
# Base image
FROM node:alpine as builder

# Switch workdir to '/app'
WORKDIR '/usr/app'

# Copy package.json into
# the container
COPY package.json .

# Install all the deps
RUN npm install

# Copy the rest of the
# files into the container
COPY . .

# Build the production files
RUN npm run build

# Run Phase
FROM node:alpine
WORKDIR /usr/app
COPY package.json ./
RUN npm install
COPY --from=builder /usr/app/dist .
CMD ["node", "server.js"]