FROM node:8.2.1
ENV NODE_ENV=production
ENV HOST 0.0.0.0
RUN mkdir -p /app
COPY . /app
WORKDIR /app
EXPOSE 3000
RUN npm install
RUN npm run build
CMD ["npm", "start"]