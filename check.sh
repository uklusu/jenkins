for server in $(cat /home/ubuntu/ip)
do
  if ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa ubuntu@$server docker ps "List containers"
  then
    echo "Server $server: OK"
  else echo "ZA WARUDO" ; sleep 2m
  fi
done
