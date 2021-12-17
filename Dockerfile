FROM vuejs/ci:latest
LABEL maintainer 'Michel Eckhardt <michel.desenvolvedor@gmail.com>'
COPY . /opt
WORKDIR /opt
RUN npm install 
ENTRYPOINT npm run serve
EXPOSE 8080  