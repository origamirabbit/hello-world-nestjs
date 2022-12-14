# Using Node:16.14.0-alpine Image
# the necessary build tools required for dependencies with native build (node-gyp, python, gcc, g++, make)

# First Stage : to install and build dependences
FROM node:16.14.0-alpine AS builder
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build


# Second Stage : Setup command to run your app using lightweight node image
FROM node:16.14.0-alpine
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["npm", "run", "start:prod"]
