#!/usr/bin/env python3

from power_api import SixfabPower, Definition
import time

api = SixfabPower()


print("************* Input Sensors **************")
print("Input Temp: " + str(api.get_input_temp()))
print("Input Voltage: " + str(api.get_input_voltage()))
print("Input Current: " + str(api.get_input_current()))
print("Input Power: " + str(api.get_input_power()))                     #Required delay #default 50

print("************* System Sensors **************")
print("System Temp: " + str(api.get_system_temp()))
print("System Voltage: " + str(api.get_system_voltage()))
print("System Current: " + str(api.get_system_current()))               #Required delay #default 50
print("System Power: " + str(api.get_system_power()))                   #Required delay #default 50

print("************* Battery **************")
print("Battery Temp: " + str(api.get_battery_temp()))
print("Battery Voltage: " + str(api.get_battery_voltage()))
print("Battery Current: " + str(api.get_battery_current()))
print("Battery Power: " + str(api.get_battery_power()))
print("Battery Level: " + str(api.get_battery_level()))
print("Battery Health: " + str(api.get_battery_health()))
print("Battery Max Charge Level: " + str(api.get_battery_max_charge_level()))
print("Battery Capacity: " + str(api.get_battery_design_capacity()))

print("************* Safe Shutdown **************")
print("Battery Safe Shutdown Battery Level: " + str(api.get_safe_shutdown_battery_level()))
print("Battery Safe Shutdown Battery Status: " + str(api.get_safe_shutdown_battery_status()))

print("************* Fan **************")
print("Fan Health: " + str(api.get_fan_health()))
print("Fan Speed: " + str(api.get_fan_speed()))
print("Fan Fan Automation: " + str(api.get_fan_automation()))

print("************* rtc time **************")
print("RTC Time: " + str(api.get_rtc_time(Definition.TIME_FORMAT_EPOCH)))
print("RTC Time: " + str(api.get_rtc_time(Definition.TIME_FORMAT_DATE_AND_TIME)))

print("************* Firmware Ver **************")
print("Firmware Ver: " + str(api.get_firmware_ver()))

print("************* Event **************")
print("IDs of Scheduled Events: " + str(api.get_scheduled_event_ids()))