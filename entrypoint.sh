wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/xmrstak/config.txt
wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/xmrstak/pools.txt
if [ $PORT ]; then
  sed -i "s/16001/$PORT/g" config.txt
fi
while true
do
	/usr/local/bin/xmr-stak &
	sleep 300
	pkill xmr-stak
	sleep 300
done
