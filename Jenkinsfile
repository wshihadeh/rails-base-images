pipeline {
  parameters {
    string(name: 'REGISTRY', defaultValue: 'index.docker.io', description: "Docker Registry domain")
  }

  
  
  stages {
    stage('Checkout SCM') {
      steps {
        checkout scm: [$class: 'GitSCM', branches: [[name: 'master']], userRemoteConfigs: [[url: 'git@github.com:wshihadeh/rails-base-images.git']]]
      }
    }

    stage('Install the gems') {
      steps {
        sh '''#!/bin/bash -le
          make config
        '''
      }
    }

    stage('Build the base image') {
      steps {
        sh '''#!/bin/bash -le
          REGISTRY=$REGISTRY make build
        '''
      }
    }

    stage('Push the base image') {
      steps {
        sh '''#!/bin/bash -le
          REGISTRY=$REGISTRY make push
        '''
      }
    }

  }

  post {
    always {
      deleteDir()
    }
  }
}
