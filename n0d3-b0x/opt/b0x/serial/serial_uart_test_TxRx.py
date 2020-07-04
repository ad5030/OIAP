#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Test du port série
import serial
test_string = "Je teste le port série 1 2 3 4 5".encode('utf-8')
port_list = ["/dev/ttyAMA0","/dev/ttyAMA0","/dev/ttyS0","/dev/ttyS"]
for port in port_list:
  try:
    serialPort = serial.Serial(port, 9600, timeout = 2)
    print ("Port Série", port, " ouvert pour le test:")
    bytes_sent = serialPort.write(test_string)
    print ("Envoyé", bytes_sent, "octets")
    loopback = serialPort.read(bytes_sent)
    if loopback == test_string:
      print ("Reçu ",len(loopback), "octets identiques. Le port", port,"fonctionne bien ! \n")
    else:
      print ("Reçu des données incorrectes:", loopback, "sur le port série", port, "bouclé \n")
    serialPort.close()
  except IOError:
    print ("Erreur sur", port,"\n")