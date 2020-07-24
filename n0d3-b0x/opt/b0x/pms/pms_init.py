#!/usr/bin/env python3

from power_api import SixfabPower, Definition
import time

api = SixfabPower()

print("\r\n")
print("************* Fan **************")
print("Fan Health: " + str(api.get_fan_health()))
print("Fan Speed Result: " + str(api.set_fan_speed(1)))
print("Fan Speed: " + str(api.get_fan_speed()))
print("Set Fan Automation Result: " + str(api.set_fan_automation(20,60)))
print("Fan Automation: " + str(api.get_fan_automation()))
print("\r\n")
print("************* Others **************")
#print("Setting Watchdog Status: " + str(api.set_watchdog_status(1)))
#print("Getting Watchdog Status: " + str(api.get_watchdog_status()))
print("RGB Animation.: " + str(api.set_rgb_animation(Definition.RGB_DISABLED,Definition.BLUE,Definition.RGB_SLOW)))
print("RGB Animation Status.: " + str(api.get_watchdog_status()))
print("Result Bat. Max Char. Level: " + str(api.set_battery_max_charge_level(80)))
print("Bat. Max Char. Level: " + str(api.get_battery_max_charge_level()))
print("Result Safe Shutdown Bat Lev.: " + str(api.set_safe_shutdown_battery_level(40)))
print("Safe Shutdown Bat Lev.: " + str(api.get_safe_shutdown_battery_level()))
print("Result Safe Shutdown Bat Status.: " + str(api.set_safe_shutdown_battery_status(1)))
print("Safe Shutdown Bat Status.: " + str(api.get_safe_shutdown_battery_status()))
#print("Button 1 Status: " + str(api.getButton1Status()))
#print("Button 2 Status: " + str(api.getButton2Status()))

# RTC
print("\r\n")
print("************* RTC **************")
#print("RTC: " + str(api.setRtcTime(1254852)))
#print("RTC: " + str(api.getRtcTime(Definition.TIME_FORMAT_DATE_AND_TIME)))
epoch = time.time() # to get timestamp in seconds in GMT0
# to get local time on raspberry pi
localtime = time.asctime( time.localtime(time.time()) )
#print("Local current time :", localtime)
# to get timezone difference as minus
#print(time.timezone)
# standard epoch time with no location specific
#print("Epoch Time: " + str(int(epoch)))

# to calculate epoch with respect to local time
# use it for set_rtc_time() function as timestamp (epoch - time.timezone)
#print("Epoch Local: " + str(int(epoch) - time.timezone))
print("Result: " + str(api.set_rtc_time(int(epoch) - time.timezone + 3600)))
print("RTC Time: " + str(api.get_rtc_time(Definition.TIME_FORMAT_EPOCH)))
print("RTC Time: " + str(api.get_rtc_time(Definition.TIME_FORMAT_DATE_AND_TIME)))


#print("Ask Watchdog Alarm: " + str(api.askWatchdogAlarm()))

# Battery Design Cap
print("\r\n")
print("************* Battery Design Cap **************")
print("Set Battery Design Capacity Result: " + str(api.set_battery_design_capacity(3400)))
print("Battery Design Capacity: " + str(api.get_battery_design_capacity()))

## Create Scheduled Events 
#print("Result creating Scheduled Event: " + str(api.createScheduledEvent(0,1,2,120,1,(Definition.THURSDAY | Definition.FRIDAY),0)))
#print("Result creating Scheduled Event: " + str(api.createScheduledEvent(1,1,2,120,1,1,0)))

# Remove event by using id
#print("Result removing Scheduled Event: " + str(api.removeScheduledEvent(1)))

# Remove all events
#print("Result removing all Scheduled Event: " + str(api.removeAllScheduledEvents()))

# Firmware Ver.
print("\r\n")
print("************* Firmware Ver **************")
print("Firmware Ver: " + str(api.get_firmware_ver()))

# Actions
#print("Hard Power Off: " + str(api.hardPowerOff()))
#print("Soft Power Off: " + str(api.softPowerOff()))
#print("Hard Reboot: " + str(api.hardReboot()))
#print("Soft Reboot: " + str(api.softReboot()))