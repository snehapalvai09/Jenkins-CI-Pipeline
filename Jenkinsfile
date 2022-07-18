pipeline {
    agent any

    stages {
        stage('Initialize')
        {
            steps{
                script{
                    def dockerHome = tool 'Docker'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        stage('Build')
        {
            agent any
            steps {
                echo 'Building docker image'
                sh "whoami"
                sh "echo $PATH"
                sh "docker build -t mywebapp ."
            }
        }
        stage('Docker Login'){
        steps{
            withCredentials([usernamePassword(credentialsId:'dockerid',usernameVariable:'USR',passwordVariable:'PWD')])
            {
                sh "docker login -u=${env.USR} -p=${env.PWD}"
            }
        }
        }
        stage('docker_push') {
            steps {
                sh "docker tag mywebapp spalvai/mywebapp"
                sh "docker images"
                sh "docker push spalvai/mywebapp:latest"

            }
        }
        stage('deploy_terraform')
        {
            steps{
                script{
                    sh "pwd"
                    sh "ls -ltr"
                    sh "terraform init"
                    sh "terraform plan"
                    sh "terraform apply --auto-approve"
                }
            }
        }
    }
}
