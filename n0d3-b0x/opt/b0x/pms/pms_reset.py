#!/usr/bin/env python3

from power_api import SixfabPower, Definition, Event
import time

api = SixfabPower()

api.reset_mcu()