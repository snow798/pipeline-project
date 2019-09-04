pipeline {
  agent {
    dockerfile {
      filename '/jenkins/Jenkinsfile'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'echo "Hello world!"'
      }
    }
  }
}