<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/mosquitto.svg" height="120" alt="Mosquitto logo">
</p>

# Mosquitto
*Mosquitto is a lightweight open-source message broker that implements the MQTT protocol, enabling efficient machine-to-machine messaging for Internet of Things devices and applications. It provides a simple way to exchange messages between connected devices with minimal network bandwidth and resource requirements.*

**Homepage:** <https://mosquitto.org>

## Prerequisites
This application requires:
- A volume in Longhorn named `mosquitto-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- A Traefik entrypoint named `mqtts` (can be overridden with `ingress.entryPoints`) for MQTTS traffic on port 8883 on your Load Balancer.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/mosquitto/values.yaml).
```yaml
global:
  # Storage request for the config folder
  configStorage: 1Gi
  
ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install mosquitto bykaj/mosquitto -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall mosquitto
```