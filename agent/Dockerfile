FROM node:14.8 as builder
WORKDIR /mnt/p10xy-agent

COPY package*.json ./
RUN npm install
COPY . .
RUN ls -las
RUN npm run build
RUN ls -las src
RUN ls -las build

FROM node:14.8 as app
WORKDIR /mnt/p10xy-agent

COPY package*.json ./
RUN npm ci --only=production
COPY --from=builder /mnt/p10xy-agent/build .

USER node

EXPOSE 8080
CMD [ "node", "index.js" ]
