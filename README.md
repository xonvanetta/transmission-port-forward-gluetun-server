# qbittorrent-port-forward-file

A Ruby script and Docker container for automatically setting qBittorrent's listening port read from a file.

## Config

### Environment Variables

| Variable     | Example                     | Default                      | Description                                                     |
|--------------|-----------------------------|------------------------------|-----------------------------------------------------------------|
| QBT_USERNAME | `username`                  | `admin`                      | qBittorrent username                                            |
| QBT_PASSWORD | `password`                  | `adminadmin`                 | qBittorrent password                                            |
| QBT_ADDR     | `http://192.168.1.100:8080` | `http://localhost:8080`    | HTTP URL for the qBittorrent web UI, with port                  |
| PORT_FILE    | `/config/my_file.txt`       | `/config/forwarded_port.txt` | Container path to the file containing the forwarded port number |

### Volumes

| Host location   | Container location | Mode | Description                                               |
|-----------------|--------------------|------|-----------------------------------------------------------|
| `/my/host/dir/` | `/config`          | `ro` | The directory in which the forwared ports file is located |

## Context

Made for use with [this VPN image](https://hub.docker.com/r/qmcgaw/private-internet-access/). Here's an example config for the VPN image:

* Environment variable: PORT_FORWARDING="on"
* Environment variable: PORT_FORWARDING_STATUS_FILE="/config/forwarded_port.txt"
* Volume: /my/host/dir:/config:rw
