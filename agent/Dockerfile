# STAGE-1: Image with development dependencies
FROM node:14.8 as builder
WORKDIR /mnt/p10xy-agent

# Creates node_modules,
# then merges the resto of the code on top of it 
COPY package*.json ./
RUN npm install
COPY . .

# Create production files,
# and check if they really there
RUN npm run build
RUN cd build && cd -

ENTRYPOINT ["/bin/bash", "-c"]

# STAGE-2: Production image
FROM node:14.8 as app
WORKDIR /mnt/p10xy-agent

COPY package*.json ./
RUN npm ci --only=production
COPY --from=builder /mnt/p10xy-agent/build .

USER node

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/node", "/mnt/p10xy-agent/main.js"]
