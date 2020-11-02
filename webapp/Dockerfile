# STAGE-1: Build static assets in node environment
FROM node:14.8 as builder
WORKDIR /mnt/p10xy/webapp

# Creates node_modules,
# then merges the resto of the code on top of it 
COPY package*.json ./
RUN npm install
COPY . .

# Create production files,
# and check if they really there
RUN npm run build
RUN cd build && cd -

# STAGE-2: Production image
FROM node:14.8 as app
WORKDIR /mnt/p10xy.luke10x.dev

# RUN apt-get update \
#     && apt-get install -y git \
#     && rm -rf /var/lib/apt/lists/*

COPY --from=builder /mnt/p10xy/webapp/build /local

RUN git init \
    && git remote add origin git@github.com:luke10x/p10xy.luke10x.dev.git

ENTRYPOINT ["/bin/bash", "-c"]
