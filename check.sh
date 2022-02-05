ip_ad= cat /home/ubuntu/ip
ping $ip_ad
while test $? -gt 0
do
echo "ZA WARUDO"
sleep 2m

ping $ip_ad
done
