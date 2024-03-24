# note-app

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Dockerfile ###
### build Images ###
``````
docker build -t front-end:v1 .
``````
#### run dockerfile ###
``````
docker run -d -p 8080:8000 --name note-app front-end:v1
``````


### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

### vuetify material ###
https://vuetifyjs.com/en/

### material icon ###
https://pictogrammers.com/library/mdi/
