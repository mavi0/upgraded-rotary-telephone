export PATH=$PATH:~/.local/bin
#ps aux |grep python |grep -v 'SimpleHTTPServer' |awk '{print $2}' |xargs kill
mkdir iperfLogs
mkdir pingLogs
mkdir speedtestLogs

killall python
killall python3
rm -f *.log
rm -f *.json
python3 main.py

