<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/sonarr.svg" height="120" alt="Sonarr logo">
</p>

# Sonarr
*Sonarr is a smart PVR (Personal Video Recorder) application that automates the downloading and organization of TV shows from various sources based on user-defined quality preferences and release schedules.*

**Homepage:** <https://sonarr.tv>

## Prerequisites
This application requires:
- A volume in Longhorn named `bazarr-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- The SMB credentials stored in the secret `smb-credentials` in the `default` namespace.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/sonarr/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3
  
  # Source and target for your downloads folder
  downloads:
    # Mount path in the container
    mountPath: /downloads
    # Source on the SMB share
    source: //SERVER/Downloads
    subPath: ""

  # Source and target for your series folder
  series:
    # Mount path in the container
    mountPath: /tv
    # Source on the SMB share
    source: //SERVER/Media
    subPath: Series

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install sonarr bykaj/sonarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall sonarr
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