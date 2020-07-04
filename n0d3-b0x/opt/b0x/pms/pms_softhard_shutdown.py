#!/usr/bin/env python3

from power_api import SixfabPower, Definition, Event
import time

api = SixfabPower()

print("Soft Pwr-Off set: " + str(api.create_scheduled_event(1, Definition.EVENT_INTERVAL, Definition.EVENT_ONE_SHOT, 15, Definition.INTERVAL_TYPE_SEC, 0, 3, 500)))

print("Hard Pwr-Off set: " + str(api.create_scheduled_event(2, Definition.EVENT_INTERVAL, Definition.EVENT_ONE_SHOT, 30, Definition.INTERVAL_TYPE_SEC, 0, 2, 500)))
