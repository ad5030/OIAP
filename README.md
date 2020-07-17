
# OIAP Scripts

1. [n0d3 b0x](n0d3-b0x/README.md)
2. [n0d3 r2d2](n0d3-r2d2/README.md)

## Directory structure

```sh
├── CHANGELOG.md
├── LICENSE
├── README.md
├── n0d3-b0x
│   ├── README.md
│   ├── opt
│   │   └── b0x
│   │       ├── gps
│   │       │   └── gps_get_data.py
│   │       ├── os
│   │       │   ├── _ENV_
│   │       │   ├── .os_backup_exclude
│   │       │   ├── os_backup.sh
│   │       │   ├── os_clean.sh
│   │       │   ├── os_cloudflare_dns_update.sh
│   │       │   ├── os_ipset_update.sh
│   │       │   ├── os_novnc_websockify.sh
│   │       │   ├── os_security_network.sh
│   │       │   └── os_security_update.sh
│   │       ├── pms
│   │       │   ├── pms_create_event.py
│   │       │   ├── pms_init.py
│   │       │   ├── pms_read_sensors.py
│   │       │   ├── pms_rtc_time.py
│   │       │   ├── pms_softhard_shutdown.py
│   │       │   └── pms_upgrade_api.sh
│   │       │   └── pms_upgrade_firmware.py
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

## CHANGELOG

[CHANGELOG](CHANGELOG.md)

## LICENCE

[LICENCE](LICENCE.md)