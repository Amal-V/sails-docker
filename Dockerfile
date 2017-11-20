FROM node:boron
MAINTAINER Amal Varghese amalchirackal@gmail.com
RUN npm install -g sails grunt
COPY /app/package.json /app/
WORKDIR /app/
RUN npm install
COPY /app /app
EXPOSE 1337
CMD ["sails", "lift" ]

