import time, configparser, json, bp_send, jsonmerge


def send_json_yocto():
    config = configparser.ConfigParser()
    config.sections()
    config.read("main.conf")
    config.sections()
    server_hostname = config['DEFAULT']['hostname']
    api_port = config['DEFAULT']['api_port']

    with open("voltage.json", 'r') as f:
        yocto_json = json.load(f)

    bp_send.send_json(server_hostname, api_port, "yocto", yocto_json)

send_json_yocto()