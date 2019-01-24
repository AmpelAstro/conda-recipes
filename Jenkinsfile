pipeline {
  agent {
    docker {
      image 'condaforge/linux-anvil-comp7'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'conda build --channel conda-forge'
      }
    }
  }
}