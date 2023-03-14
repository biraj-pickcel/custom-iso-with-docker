FROM node:18-alpine
WORKDIR /app
COPY package.json .
COPY .env .
RUN yarn install --production
COPY src src
CMD ["yarn", "start"]
EXPOSE 3000