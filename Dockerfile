FROM node:boron
MAINTAINER Amal Varghese
RUN npm install -g sails
COPY /app/package.json /app/
WORKDIR /app/
RUN npm install
COPY /app/* /app/
EXPOSE 1337
ENTRYPOINT [ "/usr/local/bin/sails" ]
CMD [ "lift" ]
