export PATH=$PATH:~/.local/bin
#ps aux |grep python |grep -v 'SimpleHTTPServer' |awk '{print $2}' |xargs kill
rm -f *.log
rm -f *.json
python3 main.py
python yocto.py
python3 bp_send.py
