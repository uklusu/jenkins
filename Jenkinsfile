#!groovy
pipeline {
    agent any

    stages {
        stage('Build_server') {
            steps {
              withAWS(credentials: 'aws_main', region: 'us-east-2'){
                sh ''' #!/bin/bash
                   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
                   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                   sudo apt-get update && sudo apt-get install terraform
                   terraform init
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
               sleep 2m
               ip_add= cat ip ;    scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/drop ubuntu@$IP_ADD:/home/ubuntu/
              sudo scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/php ubuntu@$IP_ADD:/home/ubuntu/
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/default ubuntu@$IP_ADD:/home/ubuntu/
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/shop.sh ubuntu@$IP_ADD:/home/ubuntu/
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo   mv default /etc/nginx/sites-available
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo   mv drop /etc/nginx/conf.d/
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo   mv php /etc/nginx/conf.d/
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo   php7.4-fpm
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo   nginx -s reload
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo ./shop.sh --app_dir=/var/www/html/ \
                           --document_root=/var/www/html \
                           --db_server=localhost \
                           --db_username=root \
                           --db_password=duck \
                           --db_database=mylitecartdb \
                           --db_prefix=lc_ \
                           --timezone=Europe/London \
                           --admin_folder=admin \
                           --admin_username=root \
                           --admin_password=523274 \
                           --development_type=standard \
                           --db_collation=utf8mb4_unicode_ci

                ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa buntu@$IP_ADD sudo service nginx restart

               '''

          }
        }
        stage('Deploy') {
            steps {
                echo "hello world"
            }
        }
    }
}
