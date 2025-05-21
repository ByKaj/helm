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
  
  # Change to the amount of agent nodes used for storage
  configReplicas: 3

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

## Environment and secret variables
You can add additional (or overwrite existing) environment or secret variables to the contianers in a pod by adding the following lines to `values.yaml`:
```yaml
containers:
  app:                        # Container reference key
    env:
      MY_ENV_VAR: "foo"
    secret:
      MY_SECRET_VAR: "bar"
```

## Adding storage
You can add additional volume mounts (for example a backup location on your NAS) to the containers in a pod by adding the following lines to `values.yaml`:
```yaml
containers:
  app:                        # Container reference key
    volumeMounts:
      backups:                # Volume reference key
        mountPath: /backup    # Mount path inside the container
        subPath: apps/my-app  # (Optional) relative path from the root of the share

volumes:
  backups:                    # Volume reference key
    className: smb
    accessModes: 
      - ReadWriteMany
    storage: 100Gi
    source: //SERVER/Backups
```