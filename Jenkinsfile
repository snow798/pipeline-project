def getHost(){
    def remote = [:]
    remote.name = 'mysql'
    remote.host = '192.168.117.134'
    remote.user = 'luo'
    remote.port = 22
    remote.password = 'luo'
    remote.allowAnyHosts = true
    return remote
}

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
      steps {
        sshCommand(command: 'scp -r /var/jenkins_data/workspace/pipeline-project_production/build luo@192.168.117.134:/home/luo/jenkins_res', sudo: true)
      }
    }
  }
  environment {
    CI = 'true'
  }
}
