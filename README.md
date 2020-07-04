
# OIAP Scripts

## CHANGELOG

[CHANGELOG](CHANGELOG.md)

## Directory structure

```sh
├── README.md
├── n0d3-b0x
│   ├── CHANGELOG.md
│   ├── LICENSE
│   ├── README.md
│   ├── opt
│   │   └── b0x
│   │       ├── gps
│   │       │   └── gps_get_data.py
│   │       ├── os
│   │       │   ├── os_clean.sh
│   │       │   ├── os_novnc_websockify.sh
│   │       │   └── os_security_update.sh
│   │       ├── pms
│   │       │   ├── pms_create_event.py
│   │       │   ├── pms_init.py
│   │       │   ├── pms_read_sensors.py
│   │       │   ├── pms_rtc_time.py
│   │       │   ├── pms_softhard_shutdown.py
│   │       │   └── pms_upgrade.sh
│   │       ├── serial
│   │       │   └── serial_uart_test_TxRx.py
│   │       └── sms
│   │           └── sms_sms2mail.pl
│   └── var
│       └── www
│           └── html
│               ├── error_page
│               │   ├── 401.html
│               │   ├── 403.html
│               │   ├── 404.html
│               │   ├── 421.html
│               │   └── 50x.html
│               └── pi.txt
└── n0d3-r2d2
    ├── README.md
    └── opt
        └── r2d2
            └── os
                └── osx_send_message.sh
```

## LICENCE

[LICENCE](LICENCE.md)