pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = 'dockerhub-cred'                // Jenkins에 등록한 Docker Hub 자격증명 ID
    IMAGE_NAME = 'visionn7111/nginx-web'                    // Docker Hub 저장소명
    SERVER_IP = '13.124.177.239'                            // 웹서버 IP
  }

  stages {
    stage('Clone') {
      steps {
        git url: 'https://github.com/itcen-project-2team/ci-cd-test-repo', branch: 'main'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t $IMAGE_NAME .'
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: "${DOCKERHUB_CREDENTIALS}",
          usernameVariable: 'visionn7111',
          passwordVariable: 'tjdrhdgkfrp1!'
        )]) {
          sh '''
            echo tjdrhdgkfrp1! | docker login -u visionn7111 --password-stdin
            docker push $IMAGE_NAME
          '''
        }
      }
    }

    stage('Deploy to Web Server') {
      steps {
        sh '''
        ssh -o StrictHostKeyChecking=no ubuntu@$SERVER_IP '
          docker pull $IMAGE_NAME &&
          docker stop nginx-web || true &&
          docker rm nginx-web || true &&
          docker run -d --name nginx-web -p 80:80 $IMAGE_NAME
        '
        '''
      }
    }
  }
}
