# 1. Imagen oficial ligera Node.js
FROM node:18-alpine

# 2. Directorio de trabajo
WORKDIR /app

# 3. Copiar package.json y package-lock.json
COPY package*.json ./

# 4. Instalar dependencias
RUN npm install

# 5. Copiar el resto del código
COPY . .

# 6. Exponer puerto 3000
EXPOSE 3000

# 7. Comando de inicio
CMD ["npm", "start"]


