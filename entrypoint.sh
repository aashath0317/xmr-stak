wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/xmrstak/config.txt
wget https://raw.githubusercontent.com/cbwang2016/xmr-stak/master/xmrstak/pools.txt
sed -i "s/16001/$PORT/g" config.txt
/usr/local/bin/xmr-stak
