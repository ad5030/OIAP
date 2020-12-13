#!/usr/bin/env python3

from power_api import SixfabPower, Event, Definition
import time

api = SixfabPower()

print("\r\n")
print("************* Fan **************")
print("Fan Health: " + str(api.get_fan_health()))
print("set Fan Mode: " + str(api.set_fan_mode(3,10)))
print("get Fan Mode: " + str(api.get_fan_mode()))
print("get Fan Speed: " + str(api.get_fan_speed(10)))
print("set Fan Automation Result: " + str(api.set_fan_automation(20,60,10)))
print("get Fan Automation: " + str(api.get_fan_automation(10)))
print("\r\n")
print("************* Others **************")
#print("Setting Watchdog Status: " + str(api.set_watchdog_status(1)))
#print("Getting Watchdog Status: " + str(api.get_watchdog_status()))
print("set RGB Animation.: " + str(api.set_rgb_animation(Definition.RGB_DISABLED,Definition.BLUE,Definition.RGB_SLOW,10)))
print("get RGB Animation Status.: " + str(api.get_rgb_animation(10)))
print("set Result Bat. Max Char. Level: " + str(api.set_battery_max_charge_level(80,10)))
print("get Bat. Max Char. Level: " + str(api.get_battery_max_charge_level(10)))
print("set Result Safe Shutdown Bat Lev.: " + str(api.set_safe_shutdown_battery_level(40,10)))
print("get Safe Shutdown Bat Lev.: " + str(api.get_safe_shutdown_battery_level(10)))
print("set Result Safe Shutdown Bat Status.: " + str(api.set_safe_shutdown_status(1,10)))
print("get Safe Shutdown Bat Status.: " + str(api.get_safe_shutdown_status(10)))
#print("set WatchDog Interval.: " + str(api.set_watchdog_interval(10,10)))
#print("get WatchDog Interval.: " + str(api.get_watchdog_interval(10)))
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
print("Result: " + str(api.set_rtc_time(int(epoch) - time.timezone )))
print("RTC Time: " + str(api.get_rtc_time(Definition.TIME_FORMAT_EPOCH)))
print("RTC Time: " + str(api.get_rtc_time(Definition.TIME_FORMAT_DATE_AND_TIME)))


#print("Ask Watchdog Alarm: " + str(api.askWatchdogAlarm()))

# Battery Design Cap
print("\r\n")
print("************* Battery Design Cap **************")
print("set Battery Design Capacity Result: " + str(api.set_battery_design_capacity(3400,10)))
print("get Battery Design Capacity: " + str(api.get_battery_design_capacity(10)))

# Firmware Ver
print("\r\n")
print("************* Firmware Ver **************")
print("Firmware Ver: " + str(api.get_firmware_ver()))

# Event
print("\r\n")
print("************* Event **************")
print("Result removing all Scheduled Event: " + str(api.remove_all_scheduled_events(200)))
#print("Result creating Scheduled Event: " + str(api.create_scheduled_event(1,Definition.EVENT_TIME,Definition.EVENT_REPEATED,23400,1,Definition.EVERYDAY,Definition.HARD_POWER_ON,200)))
#print("IDs of Scheduled Events: " + str(api.get_scheduled_event_ids(50)))


# Actions
#print("Hard Power Off: " + str(api.hardPowerOff()))
#print("Soft Power Off: " + str(api.softPowerOff()))
#print("Hard Reboot: " + str(api.hardReboot()))
#print("Soft Reboot: " + str(api.softReboot()))