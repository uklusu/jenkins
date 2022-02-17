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
                   terraform init
                   terraform apply -auto-approve
                   sleep 5
                   terraform apply -auto-approve
                   terraform output -raw  test_server_ip > /home/ubuntu/iptest
                   terraform output -raw  prod_server_ip > /home/ubuntu/ipprod
                   sudo chmod 777 check.sh
                   #little_jo_jo_reference_here_to_give_time_for_instaling_docker
                   echo "ZA WARUDO"
                   sleep 2m
                '''
                echo "he world"
              }
            }
        }

        stage('sending files_for_test') {
          environment {
            IP_ADD =  sh(returnStdout: true, script: "cat /home/ubuntu/iptest")
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
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/drop          ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/php           ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/default       ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/shop.sh       ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/Dockerfile    ubuntu@$IP_ADD:/home/ubuntu
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/dock.sh       ubuntu@$IP_ADD:/home/ubuntu


               '''

          }
        }
        stage('creating docker container with demo website on test') {
          environment {
            IP_ADD =  sh(returnStdout: true, script: "cat /home/ubuntu/iptest")
          }
            steps {
              sh ''' #!/bin/bash
              ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker build /home/ubuntu -t uklusu/test



              ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo  docker ps -q --filter "name=servs" |  grep -q . && ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker stop servs && ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo  docker rm  servs
              ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker run -d --name servs -p 80:80 uklusu/test



              '''

            }
        }
    stage('testing') {
      environment {
        IP_ADD =  sh(returnStdout: true, script: "cat /home/ubuntu/iptest")
      }
        steps {
          sh '''
                         export status=$(curl -o /dev/null -s -w "%{http_code}\n" http://$IP_ADD/index.php)
                         if [ status==301 ]
                         then
                         exit 0
                         else
                         exit 1
                         fi
                         '''
        }
    }
    stage('starting_demo_at_future_prod') {
      environment {
        IP_ADD =  sh(returnStdout: true, script: "cat /home/ubuntu/iptest")
        IP_PROD =  sh(returnStdout: true, script: "cat /home/ubuntu/ipprod")
      }
        steps {
          sh '''

          ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker login -u uklusu -p 88888888q
            ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker push uklusu/test

            ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_PROD sudo docker run  -d --name servs    -p 80:80 uklusu/test

          '''

        }
    }
  }
}
