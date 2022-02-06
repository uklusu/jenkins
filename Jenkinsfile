#!groovy
pipeline {
    agent any
    triggers {
        githubPush()
      }
    stages {
        stage('Build_server') {

            steps {
              withAWS(credentials: 'aws_main', region: 'us-east-2'){
                sh ''' #!/bin/bash

                   terraform apply -auto-approve
                   terraform output -raw  webserver_public_ip_adress > /home/ubuntu/ip
                   sudo chmod 777 check.sh
                   #checking_server__and_little_jo_jo_reference_here_to_give_time_for_instaling_docker
                   sudo bash check.sh
                '''
                echo "hello world"
              }
            }
        }

        stage('Test') {
          environment {
            IP_ADD =  sh(returnStdout: true, script: "cat /home/ubuntu/ip")
          }
            steps {
              sh ''' #!/bin

               sudo chmod 777 shop.sh
               sudo chmod 777 drop
               sudo chmod 777 php
               sudo chmod 777 default
               sudo chmod 777 dock.sh
               echo "sending files"
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/.dockerignore ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/.dockerignore ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/drop ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/php ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/default ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/shop.sh ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/Dockerfile ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/dock.sh ubuntu@$IP_ADD:/home/ubuntu

               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker build /home/ubuntu -t test


               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker run -d --name servs -p 80:80 test||true
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker exec -it servs ./etc/nginx/shop.sh --app_dir=/var/www/html/ \
                            --document_root=/var/www/html \
                            --db_server=database.cfxybhsetvnk.us-east-2.rds.amazonaws.com \
                            --db_username=root \
                            --db_password=database \
                            --db_database=mylitecartdb \
                            --db_prefix=lc_ \
                            --timezone=Europe/London \
                            --admin_folder=admin \
                            --admin_username=root \
                            --admin_password=523274 \
                            --development_type=standard \
                            --db_collation=utf8mb4_unicode_ci
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
