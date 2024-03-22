#Base Images
FROM node:21.7.1

# RUN apt-get update && apt-get -y

#copy inventoryfile to containerfile images
COPY . .

#install 
RUN npm i

#port
EXPOSE 8080

#start
CMD [ "npm","run","serve" ]
