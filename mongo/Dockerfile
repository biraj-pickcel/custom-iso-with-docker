FROM mongo
COPY mongod.conf /etc/
RUN mkdir -p /home/database
COPY dump /home/database/dump/
ENV DB_NAME=biraj
ENV DB_USER=biraj
ENV DB_PASS=biraj\$21..
COPY create-mongo-user.js /docker-entrypoint-initdb.d/
COPY restore.sh /docker-entrypoint-initdb.d/
EXPOSE 27017
CMD ["mongod", "--auth", "--config", "/etc/mongod.conf"]
