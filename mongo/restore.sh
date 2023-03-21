#!/bin/bash
set -e

mongorestore -u $MONGO_USERNAME --password $MONGO_PASSWORD --authenticationDatabase $MONGO_DB /home/database/dump
