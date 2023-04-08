FROM node:16-alpine as builder


RUN mkdir -p '/node/app'
RUN chown node /node/app
USER node
WORKDIR '/node/app'

COPY --chown=node:node ./package.json .
RUN npm install
COPY --chown=node:node . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /node/app/build /usr/share/nginx/html

