FROM node:lts-alpine as release
WORKDIR /opt/kitchen
COPY . /opt/kitchen
RUN npm ci
EXPOSE 3000
CMD ["node", "server.js"]
