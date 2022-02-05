sudo chmod 777 /home/ubuntu/ip
IP_ADD= cat /home/ubuntu/ip
 ssh -o -tt StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD
while test $? -gt 0
do
echo "ZA WARUDO"
sleep 2m

ssh -o -tt StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD
done
