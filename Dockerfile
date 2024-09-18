FROM node:20-alpine3.18 AS build01
WORKDIR /app
COPY package*.json .
RUN npm i
COPY . .
RUN npm run build

FROM nginx:1.21.3-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build01 /app/dist /usr/share/nginx/html
EXPOSE 80
