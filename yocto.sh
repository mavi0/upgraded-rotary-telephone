export PATH=$PATH:~/.local/bin
#ps aux |grep python |grep -v 'SimpleHTTPServer' |awk '{print $2}' |xargs kill
mkdir voltageLogs
sudo python yocto.py
python3 bp_send.py
