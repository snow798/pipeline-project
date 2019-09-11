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
    stage('Deploy for production 67') {
      when {
        branch '67'
      }
      steps {
        sh './jenkins/scripts/deploy-for-production.sh'
        input 'Finished using the web site? (Click "Proceed" to continue)'
      }
    }
    stage('Send 9010 Test server...') {
      def remote = [:]
      remote.name = 'test'
      remote.host = 'test.domain.com'
      remote.user = 'root'
      remote.password = 'password'
      remote.allowAnyHosts = true
      steps {
          echo '444444444444'
          writeFile file: 'abc.sh', text: 'ls -lrt'
          sshPut remote: remote, from: 'abc.sh', into: '.'
      }
    }
  }
  environment {
    CI = 'true'
  }
}
