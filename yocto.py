import os, sys
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
    print("%3.2fV DC - %3.2fV AC " % (sensorDC.get_currentValue(), sensorAC.get_currentValue()))
    
YAPI.FreeAPI()