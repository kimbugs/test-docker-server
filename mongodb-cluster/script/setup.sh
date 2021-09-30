#!/bin/bash

sleep 10 | echo "Waiting for the servers"

mongo mongodb://mongo-1:27017 /script/setReplication.js