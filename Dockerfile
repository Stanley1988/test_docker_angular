# Stage 1: Build the Angular app
FROM node:16 AS builder
# FROM node:14.20.0 AS builder

WORKDIR /app

COPY package.json package-lock.json /app/
RUN npm install

COPY . /app
RUN npm run build --prod

# Stage 2: Serve the Angular app using nginx
FROM nginx:1.21.0-alpine

COPY --from=builder /app/dist/* /usr/share/nginx/html/