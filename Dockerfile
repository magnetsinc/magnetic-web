FROM node:alpine3.18.4 as build

WORKDIR /app

COPY package.json ./

COPY package-lock.json package-lock.json

RUN npm install

COPY . ./

RUN npm run build

FROM nginx:alpine3.18.4 as release

COPY --from=build /app/build /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
