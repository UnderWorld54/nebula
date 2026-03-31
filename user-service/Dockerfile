# 1. On part d'une image Node.js légère (Alpine = mini-Linux)
FROM node:18-alpine


# 2. On crée un dossier de travail dans le conteneur
WORKDIR /app


# 3. On copie d'abord package.json (pour profiter du cache Docker)
COPY package.json .


# 4. On installe les dépendances (express)
RUN npm install --production


# 5. On copie le code source
COPY index.js .


# 6. On expose le port (documentation, pas obligatoire)
EXPOSE 3001


# 7. On lance l'application
CMD ["node", "index.js"]

