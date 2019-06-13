export PATH=$PATH:~/.local/bin
#ps aux |grep python |grep -v 'SimpleHTTPServer' |awk '{print $2}' |xargs kill
rm -f *.log
python3 iperf.py
python3 ping.py
python3 speedtest.py
python yocto.py
