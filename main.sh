export PATH=$PATH:~/.local/bin
#ps aux |grep python |grep -v 'SimpleHTTPServer' |awk '{print $2}' |xargs kill
killall python
killall python3
rm -f *.log
rm -f *.json
python3 main.py

