FROM node:boron
MAINTAINER Amal Varghese
RUN npm install -g sails grunt
COPY /app/package.json /app/
WORKDIR /app/
RUN npm install
COPY /app /app
EXPOSE 1337
#ENTRYPOINT [ "/usr/local/bin/sails" ]
CMD ["sails", "lift" ]
