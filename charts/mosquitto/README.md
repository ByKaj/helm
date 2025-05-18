<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/mosquitto.svg" height="120" alt="Mosquitto logo">
</p>

# Mosquitto
*Mosquitto is a lightweight open-source message broker that implements the MQTT protocol, enabling efficient machine-to-machine messaging for Internet of Things devices and applications. It provides a simple way to exchange messages between connected devices with minimal network bandwidth and resource requirements.*

**Homepage:** <https://mosquitto.org>

## Usage
**NOTE:** This application uses a **Traefik IngressRouteTCP** router. Make sure you have an entrypoint (aptly named `mqtts`, or override with `ingress.entryPoints`) for MQTTS traffic on port 8883 on your Load Balancer. The deployment will fail otherwise.

Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  app:
    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /mosquitto/config/
      name: config
      subPath: config
    - mountPath: /mosquitto/data
      name: config
      subPath: data
    - mountPath: /mosquitto/log
      name: config
      subPath: log

ingress:
  # Your domain name(s)
  domains: 
  - domain.tld
  # The subdomain of the domain (e.g. `my-app`)
  # @default -- `<app.fullname>`
  subdomainOverride: ""
  
# Add the persistent volumes
volumes:
# Config store on Longhorn
- name: config
  className: longhorn
  accessModes: 
  - ReadWriteOnce
  storage: 1Gi
  source: ""
```

Finally, install the chart:
```bash
helm install mosquitto bykaj/mosquitto -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall mosquitto
```