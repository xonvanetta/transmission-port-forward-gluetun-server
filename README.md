# transmission-port-forward-gluetun-server

A shell script and Docker container for automatically setting Transmission's listening port from Gluetun's control server.

## Config

### Environment Variables

| Variable | Example                     | Default                 | Description                                        |
|----------|-----------------------------|-------------------------|----------------------------------------------------|
| HOST     | `192.168.1.100`             | `127.0.0.1`             | Transmission host                                  |
| PORT     | `10109`                     | `9091`                  | Transmission port                                  |
| GTN_ADDR | `http://192.168.1.100:8000` | `http://localhost:8000` | HTTP URL for the gluetun control server, with port |

## Example

### Docker-Compose

The following is an example docker-compose:

```yaml
  transmission-port-forward-gluetun-server:
    image: ghcr.io/xonvanetta/transmission-port-forward-gluetun-server:0.0.1
    restart: unless-stopped
    environment:
      - GTN_ADDR=http://192.168.1.100:8000
      - HOST=192.168.1.101
      - PORT=10109
```