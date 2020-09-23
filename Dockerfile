FROM node:12.18-alpine

ARG DATABASE_TYPE
ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL \
    DATABASE_TYPE=$DATABASE_TYPE

WORKDIR /app
EXPOSE 3000

RUN yarn config set --home enableTelemetry 0
RUN yarn next telemetry disable

COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

COPY . /app
RUN yarn build

# prune dev dependency
# RUN yarn install --frozen-lockfile --production

CMD ["yarn", "start"]
