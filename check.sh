IP_ADD= cat ip
 ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD
while test $? -gt 0
do
echo "ZA WARUDO"
sleep 2m

 ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD
done
