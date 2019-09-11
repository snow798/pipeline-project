#!/usr/bin/env sh

set -x
npm run build
set +x

set -x
npm install serve
set +x

set -x
./node_modules/serve/bin/serve.js -c 0 -s build &
sleep 1
echo $! > .pidfile
set +x

echo 'Now...'
echo 'Visit http://localhost:5000 to see your Node.js/React application in action.'
