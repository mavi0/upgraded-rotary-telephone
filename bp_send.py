import json, jsonmerge, requests, hashlib, configparser, socket


def send_json(server_hostname, server_port, datafield, json_data): 
    uuid = hashlib.md5(socket.gethostname().encode('utf-8')).hexdigest()
    url = 'http://' + server_hostname + ':' + server_port + '/api/set_stats/' + uuid + '-' + datafield
    print(url)
    res = requests.post(url, json=json_data)



