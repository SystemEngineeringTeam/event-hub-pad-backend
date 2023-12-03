FROM node
WORKDIR /usr/src/app

COPY node/package*.json ./

RUN npm install

COPY . .

EXPOSE 8000

CMD ["node","node/index.js"]