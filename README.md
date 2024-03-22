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

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

### Dockerfile ###


### build Images ###
docker build -t front-end:v1 .
``````

### run dockerfile ###
docker run -d -p 8080:8000 --name note-app front-end:v1
``````
