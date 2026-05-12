# Etap 1: Budowanie aplikacji Vite/React
FROM node:20-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Etap 2: Serwowanie plików statycznych przez Nginx
FROM nginx:alpine
# Kopiujemy zbudowane pliki
COPY --from=build /app/dist /usr/share/nginx/html
# Kopiujemy konfigurację Nginx dla React Router
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Nasłuchujemy na porcie 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
