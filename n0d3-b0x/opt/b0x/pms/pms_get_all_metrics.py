import requests

response = requests.get(
  "http://localhost:6060/metrics"
).json()

print(response)