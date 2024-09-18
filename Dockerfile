FROM node:16-alpine AS builder
WORKDIR /app
COPY package.json ./
RUN npm install --force
COPY . .
RUN npm run build

FROM nginx:1.13.12-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80

