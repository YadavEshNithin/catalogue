FROM node:20-alpine3.21 AS builder
WORKDIR /opt/server
COPY package.json .
COPY *.js .
RUN npm install

FROM node:20-alpine3.21
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# RUN chown -R roboshop:roboshop /opt/server
ENV MONGO_URL="mongodb://mongodb:27017/catalogue" \
    MONGO="true"
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server
CMD ["node", "server.js"]



# FROM node:20-alpine3.21
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# RUN chown -R roboshop:roboshop /opt/server
# RUN npm install
# ENV MONGO_URL="mongodb://mongodb:27017/catalogue" \
#     MONGO=true
# USER roboshop
# CMD ["node", "server.js"]
