#!/usr/bin/env sh

set -x
npm run build
set +x

set -x
npm install serve
set +x

echo 'push code... 77777777777777777777 prod'
set -x
ssh luo@192.168.117.134
scp -r luo@192.168.117.134:/var/jenkins_data/workspace/pipeline-project_production/build/ /home/luo/jenkins_res/
set +x
echo 'push end'

set -x
./node_modules/serve/bin/serve.js -c 0 -s build &
sleep 1
echo $! > .pidfile
set +x

echo 'Now...'
echo 'Visit http://localhost:5000 to see your Node.js/React application in action.'
echo '(This is why you specified the "args ''-p 5000:5000''" parameter when you'
echo 'created your initial Pipeline as a Jenkinsfile.)'
