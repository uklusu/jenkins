#!groovy
pipeline {
    agent any

    stages {
        stage('Build_server') {

            steps {
              withAWS(credentials: 'aws_main', region: 'us-east-2'){
                sh ''' #!/bin/bash
                   sudo su
                   terraform apply -auto-approve
                   terraform output -raw  webserver_public_ip_adress > ip

                '''
                echo "hello world"
              }
            }
        }

        stage('Test') {
          environment {
            IP_ADD =  sh(returnStdout: true, script: "cat ip")
          }
            steps {
              sh ''' #!/bin

               sudo chmod 777 shop.sh
               sudo chmod 777 drop
               sudo chmod 777 php
               sudo chmod 777 default
               sudo chmod 777 dock.sh
               #little_jo_jo_reference_here_to_give_time_for_instaling_docker
               sydo ./check.sh


               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/.dockerignore ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/.dockerignore ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/drop ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/php ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/default ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/shop.sh ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/Dockerfile ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/dock.sh ubuntu@$IP_ADD:/home/ubuntu

               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker build /home/ubuntu -t test

               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo  docker ps -q --filter "name=servs" |  grep -q . && ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker stop servs && ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo  docker rm  servs
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker run -d --name servs -p 80:80 test
               '''

          }
        }
        stage('Deploy') {
            steps {
              sh ''' #!/bin/bash
               cat  ip
              '''

            }
        }
    }
}
