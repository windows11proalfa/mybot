FROM node:lts-buster

RUN rm -rf /var/lib/apt/lists/*

COPY package.json .

RUN npm install --force

COPY . .

EXPOSE 5000

RUN npm start
