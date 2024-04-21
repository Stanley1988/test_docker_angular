# Stage 1: Build the Angular app
FROM node:14.20.0 AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod

# Stage 2: Serve the Angular app using nginx
FROM nginx:1.21.0-alpine

COPY --from=builder /app/dist/* /usr/share/nginx/html/