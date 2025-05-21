<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/prowlarr.svg" height="120" alt="Prowlarr logo">
</p>

# Prowlarr
*Prowlarr is an indexer manager/proxy that integrates with various media management applications like Sonarr, Radarr, and Lidarr. It centralizes the management of indexers across all your media applications, allowing you to configure and maintain them in one place while automatically syncing the indexers to your other applications.*

**Homepage:** <https://prowlarr.com>

## Prerequisites
This application requires:
- A volume in Longhorn named `prowlarr-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/prowlarr/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi

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
helm install prowlarr bykaj/prowlarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall prowlarr
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