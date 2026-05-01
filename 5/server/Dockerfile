FROM node:22-slim

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install
RUN npm install cors

COPY . .

EXPOSE 3001
CMD ["node", "index.js"]
