import time
import configparser
import iperf3
import json
import logging
from subprocess import check_output
from datetime import datetime
from time import sleep

config = configparser.ConfigParser()
time = datetime.now()

config.sections()
config.read('main.conf')
config.sections()

logging.basicConfig(format='[%(levelname)s] %(asctime)s %(message)s ',filename='speedtest.log',level=logging.DEBUG)

base_port = int(config['DEFAULT']['Port'])
server_hostname = config['DEFAULT']['Hostname']

logging.info("Performing Speedtest.net test....")

speedtest_json = json.loads(check_output(["speedtest-cli", "--json"]).decode("utf-8"))

with open('speedtest.json' , 'w') as speedtest_file:
        json.dump(speedtest_json, speedtest_file)

with open('speedtestLogs/%s.json' % time, 'w') as speedtest_log:
        json.dump(speedtest_json, speedtest_log)

print(json.dumps(speedtest_json))

logging.info("Complete!\n")
