FROM mongo
COPY mongo-backup.sh /
RUN mkdir -p /home/database
COPY dump /home/database/dump
COPY create-mongo-user.js /docker-entrypoint-initdb.d/
COPY restore.sh /docker-entrypoint-initdb.d/
EXPOSE 27017
CMD ["mongod", "--auth"]
