 ssh -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD
while test $? -gt 0
do
echo "ZA WARUDO"
sleep 2m

ssh  -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD
done
