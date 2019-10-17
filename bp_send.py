import json, jsonmerge, requests, hashlib, configparser, socket


def send_json(server_hostname, server_port, datafield, json_data): 
    uuid = hashlib.md5(socket.gethostname().encode('utf-8')).hexdigest()
    url = 'http://' + server_hostname + ':' + server_port + '/api/set_stats/' + uuid + '-' + datafield
    print(url)
    res = requests.post(url, json=json_data)

def send_json_yocto():
    config = configparser.ConfigParser()
    config.sections()
    config.read("main.conf")
    config.sections()
    server_hostname = config['DEFAULT']['hostname']
    api_port = config['DEFAULT']['api_port']

    with open("voltage.json", 'r') as f:
        yocto_json = json.load(f)

    send_json(server_hostname, api_port, "yocto", yocto_json)


