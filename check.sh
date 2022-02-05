for server in $(cat /home/ubuntu/ip)
do
  if ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $server "true"
  then
    echo "Server $server: OK"
  else sleep 2m
  fi
done
