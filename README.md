# transmission-port-forward-gluetun-server

A shell script and Docker container for automatically setting Transmission's listening port from Gluetun's control server.

## Config

### Environment Variables

| Variable     | Example                     | Default                 | Description                                                                    |
|--------------|-----------------------------|-------------------------|----------------------------------------------------------------------------------|
| HOST         | `192.168.1.100`             | `127.0.0.1`             | Transmission host                                                               |
| PORT         | `10109`                     | `9091`                  | Transmission port                                                               |
| GTN_ADDR     | `http://192.168.1.100:8000` | `http://localhost:8000` | HTTP URL for the gluetun control server, with port                             |
| GTN_USERNAME | `username`                  | *None*                  | Username for authentication to gluetun control server (if basic auth enabled)  |
| GTN_PASSWORD | `password`                  | *None*                  | Password for authentication to gluetun control server (if basic auth enabled)  |
| GTN_APIKEY   | `apikey`                    | *None*                  | API key for authentication to gluetun control server (if API key auth enabled) |

## Gluetun Control Server Authentication

Starting in Gluetun v3.4, authentication is required on the Gluetun control server routes.

See this link for information on how to set this up: https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/control-server.md#authentication

Once configured in Gluetun, you can configure this container to use the appropriate authentication method:
- If using `none` auth, you do not need to provide any of the authentication environment variables
- If using `basic` auth, set the `GTN_USERNAME` and `GTN_PASSWORD` environment variables
- If using `apikey` auth, set the `GTN_APIKEY` environment variable

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