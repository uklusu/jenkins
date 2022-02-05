ip_ad=$(cat /home/ubuntu/ip )
ping -n 1 $ip_ad
while test $? -gt 0
do
echo "ZA WARUDO"
sleep 2m

ping -n 1 $ip_ad
done
