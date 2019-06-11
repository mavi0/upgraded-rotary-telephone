import os, sys, time, json
sys.path.append(os.path.join("..", "..", "Sources"))
from yoctopuce.yocto_api import *
from yoctopuce.yocto_voltage import *


def die(msg):
    sys.exit(msg + ' (check USB cable)')

errmsg = YRefParam()

# Setup the API to use local USB devices
if YAPI.RegisterHub("usb", errmsg) != YAPI.SUCCESS:
    sys.exit("init error" + errmsg.value)

# Get sensor ID
sensor = YVoltage.FirstVoltage()
if sensor is None:
    die('No module connected')
m = sensor.get_module()
target = m.get_serialNumber()
print(target)

sensorDC = YVoltage.FindVoltage(target + '.voltage1')
sensorAC = YVoltage.FindVoltage(target + '.voltage2')


if not (sensorDC.isOnline()):
    die('device not connected')

if sensorDC.isOnline():
    dc = sensorDC.get_currentValue()
    ac = sensorAC.get_currentValue()
    print("%3.2fV DC - %3.2fV AC " % (dc, ac))
    print(dc)
    time = time.time()
    voltage = {}
    voltage = { "VDC" : dc, "VAC" : ac}
    print(voltage)
    with open('voltage.json', 'w') as volt_file:
        json.dump(voltage, volt_file)

    with open('voltageLogs/%s.json' % time, 'w') as volt_file:
        json.dump(voltage, volt_file)
    
YAPI.FreeAPI()