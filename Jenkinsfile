def remote = [:]
remote.name = 'test'
remote.host = '192.168.117.134'
remote.user = 'luo'
remote.password = 'luo'
remote.allowAnyHosts = true

pipeline {
  agent {
    docker {
      image 'node:8-alpine'
      args '-p 3000:3000 -p 5000:5000'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'npm config set registry https://registry.npm.taobao.org'
        sh 'node -v'
        sh 'npm -v'
        sh 'npm config get registry'
        sh 'npm install'
      }
    }
    stage('Test') {
      steps {
        sh './jenkins/scripts/test.sh'
      }
    }
    stage('Deliver for development') {
      when {
        branch 'development'
      }
      steps {
        sh './jenkins/scripts/deliver-for-development.sh'
        input 'Finished using the web site? (Click "Proceed" to continue)'
      }
    }
    stage('Deploy for production') {
      when {
        branch 'production'
      }
      steps {
        sh './jenkins/scripts/deploy-for-production.sh'
        input 'Finished using the web site? (Click "Proceed" to continue)'
      }
    }
    stage('Send 9010 Test server...') {
      steps {
          echo 'start Send 9010_Test_server...'
          sh 'ls'
          sh 'tar -cvf build.tar build'
          sshPut remote: remote, from: 'build.tar', into: './jenkins_res/'
          sshScript remote: remote, script: 'ls'
          sshScript remote: remote, script: 'tar xvf ./jenkins_res/build.tar'
      }
    }
  }
  environment {
    CI = 'true'
  }
}
