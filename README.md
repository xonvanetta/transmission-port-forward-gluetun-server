# qbittorrent-port-forward-gluetun-server

A shell script and Docker container for automatically setting qBittorrent's listening port from Gluetun's control server.

## Config

### Environment Variables

| Variable     | Example                     | Default                      | Description                                                     |
|--------------|-----------------------------|------------------------------|-----------------------------------------------------------------|
| QBT_USERNAME | `username`                  | `admin`                      | qBittorrent username                                            |
| QBT_PASSWORD | `password`                  | `adminadmin`                 | qBittorrent password                                            |
| QBT_ADDR     | `http://192.168.1.100:8080` | `http://localhost:8080`      | HTTP URL for the qBittorrent web UI, with port                  |
| GTN_ADDR     | `http://192.168.1.100:8000` | `http://localhost:8000`      | HTTP URL for the gluetun control server, with port              |

## Development

### Build Image

`docker build . -t qbittorrent-port-forward-gluetun-server`

### Run Container

`docker run --rm -it -e QBT_USERNAME=admin -e QBT_PASSWORD=adminadmin -e QBT_ADDR=http://192.168.1.100:8080 -e GTN_ADDR=http://192.168.1.100:8000 qbittorrent-port-forward-gluetun-server:latest`
