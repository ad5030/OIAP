#!/usr/bin/env python3

from power_api import SixfabPower, Definition, Event
import time

api = SixfabPower()
epoch = time.time()

# Remove all events
print("Result removing all Scheduled Event: " + str(api.remove_all_scheduled_events(200)))

# -----------------------------------------------------------
# Function for creating scheduling event
# Parameter : uint8 eventID [id]
# Parameter : uint8 scheduleType [time, interval]
# Parameter : uint8 repeat [once, repeated]
# Parameter : uint16 timeOrInterval [exact time[epoch], interval]
# Parameter : uint8 interval_type [seconds, minutes, hours]
# Parameter : uint8 repeatPeriod [day_factor]  	
# Parameter : uint8 action [start, hard shutdown, soft shutdown, hard reboot, soft reboot]
# Return : result
# -----------------------------------------------------------

# Start 6:30AM
print("Result creating Scheduled Event: " + str(api.create_scheduled_event(1,1,2,1593412200,1,Definition.EVERYDAY,1,200)))

print("IDs of Scheduled Events: " + str(api.get_scheduled_event_ids(50)))
