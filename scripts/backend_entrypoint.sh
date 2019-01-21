#!/bin/bash

if [ -f ./tmp/pids/server.pid ]; then
  echo -e "\nCleaning environment"
  rm tmp/pids/server.pid
fi

echo -e "\nChecking gems"
bundle install --quiet

echo -e "\nSetup database"
bin/rake db:setup

echo -e "\nRunning migrations"
bin/rake db:migrate

echo -e "\nRunning server"
exec "$@"
