FROM node:12.18-alpine

ARG DATABASE_TYPE
ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL \
    DATABASE_TYPE=$DATABASE_TYPE

WORKDIR /app
EXPOSE 3000

COPY package*.json /app/
RUN npm ci

COPY . /app
RUN npm run build

CMD ["npm", "start"]
