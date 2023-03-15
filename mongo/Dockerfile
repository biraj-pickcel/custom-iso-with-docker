FROM mongo
COPY mongod.conf /etc/
COPY mongo-backup.sh /
RUN mkdir -p /home/database
COPY dump /home/database/dump
RUN mkdir $HOME/backup
ENV DB_NAME=biraj
ENV DB_USER=biraj
ENV DB_PASS=biraj\$21..
COPY create-mongo-user.js /docker-entrypoint-initdb.d/
COPY restore.sh /docker-entrypoint-initdb.d/
EXPOSE 27017
CMD ["mongod", "--config", "/etc/mongod.conf"]
