export PATH=$PATH:~/.local/bin
#ps aux |grep python |grep -v 'SimpleHTTPServer' |awk '{print $2}' |xargs kill
killall python
killall python3
python yocto.py
python3 bp_send.py
