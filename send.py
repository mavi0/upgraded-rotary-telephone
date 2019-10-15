import json, jsonmerge, requests, hashlib, configparser, socket


def send_json(server_hostname, server_port, box_name, datafield, data): 
    uuid = hashlib.md5(socket.gethostname().encode('utf-8')).hexdigest() 
    res = requests.post('http://' + server_hostname + ':' + server_port + '/api/set_stats/' + uuid + '-' + datafield, json=data)






