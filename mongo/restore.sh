#!/bin/bash
set -e

mongorestore -u $DB_USER --password $DB_PASS --authenticationDatabase $DB_NAME /home/database/dump
