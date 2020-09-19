FROM node:12.18-alpine

ARG DATABASE_TYPE
ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL \
    DATABASE_TYPE=$DATABASE_TYPE

WORKDIR /app
EXPOSE 3000

COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

COPY . /app
RUN yarn build

CMD ["yarn", "start"]
