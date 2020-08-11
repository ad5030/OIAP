#!/usr/bin/env python3

import requests

response = requests.get(
  "http://localhost:6060/metrics"
).json()

print(response)