FROM node:21.7.1

# RUN apt-get update && apt-get -y

COPY . .

RUN npm i

EXPOSE 8080

CMD [ "npm","run","serve" ]
