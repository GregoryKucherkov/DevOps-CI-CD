pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: jenkins-kaniko
spec:
  serviceAccountName: jenkins-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: "Always"
      command:
        - "sleep"
      args:
        - "99d"
      env:
        - name: AWS_REGION
          value: us-east-1
        - name: AWS_ROLE_ARN
          value: arn:aws:iam::718240086377:role/hw_9_eks-jenkins-kaniko-role
        - name: AWS_WEB_IDENTITY_TOKEN_FILE
          value: /var/run/secrets/eks.amazonaws.com/serviceaccount/token

    - name: git-cli
      image: "alpine/git:latest"
      command:
        - "sleep"
      args:
        - "99d"
"""
    }
  }
  environment {
    ECR_REGISTRY   = "7182-4008-6377.dkr.ecr.us-east-1.amazonaws.com"
    IMAGE_NAME   = "lesson-9-ecr"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"
    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
  }
  stages {

    stage('Check AWS / IRSA') {
      steps {
        container('kaniko') {
          sh '''
            echo "===== ENV ====="
            env | grep AWS
            echo "===== ROLE ====="
            if [ -f "$AWS_WEB_IDENTITY_TOKEN_FILE" ]; then
              echo "Web identity token exists"
              cat $AWS_WEB_IDENTITY_TOKEN_FILE | head -5
            else
              echo "No web identity token file"
            fi
            echo "===== STS CALL ====="
            aws sts get-caller-identity || true
          '''
        }
      }
    }


    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          sh """
            /kaniko/executor \\
              --context `pwd`/django-app-src \\
              --dockerfile `pwd`/django-app-src/Dockerfile \\
              --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \\
              --cache=true
          """
        }
      }
    }
    stage('Update Chart Tag in Git') {
      steps {
        container('git-cli') {
          withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GITHUB_USER', passwordVariable: 'GITHUB_PAT')]) {
            sh '''
              git clone https://${GITHUB_USER}:${GITHUB_PAT}@github.com/${GITHUB_USER}/devops.git
              cd devops
              git config user.email "$COMMIT_EMAIL"
              git config user.name "$COMMIT_NAME"
              git checkout lesson-9
              sed -i "s|tag: .*\$|tag: \\"$IMAGE_TAG\\"|" charts/django-app/values.yaml
              git add charts/django-app/values.yaml
              git commit -m "Update image tag to $IMAGE_TAG"
              git push origin lesson-9
            '''
          }
        }
      }
    }
  }
}