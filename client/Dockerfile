FROM node:8.11 as build-deps
WORKDIR /usr/src/app
COPY package.json ./
COPY . ./
RUN npm insall

FROM nginx:1.12-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
