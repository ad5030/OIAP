#!/usr/bin/env python3

# -----------------------------------------------------------
# Function for creating scheduling event
# Parameter : uint8 eventID [id]
# Parameter : uint8 scheduleType [EVENT_TIME, EVENT_INTERVAL]
# Parameter : uint8 repeat [EVENT_ONE_SHOT, EVENT_REPEATED]
# Parameter : uint16 timeOrInterval [exact time[epoch] | EVENT_INTERVAL]
# Parameter : uint8 interval_type [INTERVAL_TYPE_SEC, INTERVAL_TYPE_MIN, INTERVAL_TYPE_HOUR]
# Parameter : uint8 repeatPeriod [day_factor | EVERYDAY]  	
# Parameter : uint8 action [HARD_POWER_ON, HARD_POWER_OFF, HARD_REBOOT, SOFT_POWER_ON, SOFT_POWER_OFF,SOFT_REBOOT]
# Return : result
#
# day_factor : Calculation of day_factor 
# [monday] –> Bit 0 [tuesday] –> Bit 1 [wednesday] –> Bit 2 [thursday] –> Bit 3 [friday] –> Bit 4 [saturday] –> Bit 5 [sunday] –> Bit 6 [RESERVED] –> Bit 7 (Default 0)
# Example Calculation for every day : day_factor = 0b01111111 = 127
# Example Calculation for (sunday + monday + tuesday) : day_factor = 0b01000011 = 67
# -----------------------------------------------------------

from power_api import SixfabPower, Definition, Event
import time

api = SixfabPower()
epoch = time.time()

# Remove all events
# -----------------
print("Result removing all Scheduled Event: " + str(api.remove_all_scheduled_events(200)))

# set HARD_POWER_ON at 6:30AM everyday
# ------------------------------------
# see https://www.epochconverter.com
# daily_exact_time formula: epoch_time_local % (24x60x60)
# daily_exact_time :
#   –> Thursday, 30 July 2020 06:30:00
#   –> epoch_local = 1596090600 (In this case local : GMT)
#   –> daily exact_time = 1596090600 % 86400 = 23400
print("Result creating Scheduled Event: " + str(api.create_scheduled_event(1,Definition.EVENT_TIME,Definition.EVENT_REPEATED,23400,1,Definition.EVERYDAY,Definition.HARD_POWER_ON,200)))

print("IDs of Scheduled Events: " + str(api.get_scheduled_event_ids(50)))
