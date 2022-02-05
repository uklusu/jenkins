for server in $(cat /home/ubuntu/ip)
do
  if ssh $server "true"
  then
    echo "Server $server: OK"
  else sleep 2m
  fi
done
