#!/bin/sh

echo "installing nodeJS dependencies"
npm cache verify
npm install --prod
# if last executed command exited ($?) with non 0 code
# then exit the script with that same code
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "running nodeJS app"
npm start
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
