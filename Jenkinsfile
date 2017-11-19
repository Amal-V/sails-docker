
pipeline {
    agent any

    stages {
        
        stage('checkout') {
            steps {
                checkout ([changelog: false, 
                   poll: false, 
                   scm: [$class: 'GitSCM', branches: [[name: '**']], 
                   doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']],
                   submoduleCfg: [], userRemoteConfigs: [[credentialsId: '0df54020-ae5b-4212-8234-fc299662e7e9', 
                   url: 'git@github.com:ProjectStasis/sails-docker.git']]]])
            }
           
        }
        
        stage('Build') {
            steps {
               sh "docker build -t ${params.ECR_REPOSITORY_URI}:latest-${env.BUILD_ID} ."
               sh "\$(aws ecr get-login --no-include-email --region ap-southeast-1)"
               sh "docker push ${params.ECR_REPOSITORY_URI}:latest-${env.BUILD_ID}"
            }
        }
        stage('Post-Build') {
            steps {
               sh "git clone  git@github.com:ProjectStasis/ecs-infra.git || true"
               dir ('ecs-infra') { 
                    sh "git pull"
                    sh "terraform init"
                    sh "terraform plan"
                }
              
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                dir ('ecs-infra') {
                    sh "printf 'yes' | terraform apply"
                }
                sh 'rm -rf ecs-infra'
            }
        }
    }
}
