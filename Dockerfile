# --- ESTAGIO 1: BUILDER & DEPENDENCIAS ---#
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .
# --- ESTAGIO 2: IMAGEM DE PRODUÇÃO LEVE --- #
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY --from=builder /app/server.js ./server.js

USER node
EXPOSE 3000

CMD ["node", "server.js"]
