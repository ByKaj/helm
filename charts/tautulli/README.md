<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/tautulli.svg" height="120" alt="Tautulli logo">
</p>

# Tautulli
*Tautulli is a monitoring and tracking tool that provides detailed statistics and insights about your Plex Media Server usage and activity. It offers comprehensive analytics on what's being watched, who's watching it, and when, along with notifications, history logging, and custom reports to help you better understand your media consumption.*

**Homepage:** <https://tautulli.com>

## Prerequisites
This application requires:
- A volume in Longhorn named `tautulli-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/tautulli/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

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
helm install tautulli bykaj/tautulli -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall tautulli
```

## Environment and secret variables
You can add additional (or overwrite existing) environment or secret variables to the contianers in a pod by adding the following lines to `values.yaml`:
```yaml
containers:
  app:                              # Container reference key
    env:
      MY_ENV_VAR: "foo"
    secret:
      MY_SECRET_VAR: "bar"
```

## Storage and volume mapping
You can add additional (or overwrite existing) volume mounts to the containers in a pod by adding the following lines to `values.yaml`:
```yaml
containers:
  app:                              # Container reference key
    volumeMounts:
      backups:                      # Volume reference key
        "apps/my-app": "/backup"    # Format: "[source relative path]": "<container mount path>"

volumes:
  backups:                          # Volume reference key
    className: smb
    accessModes: 
      - ReadWriteMany
    storage: 100Gi
    source: //SERVER/Backups
```