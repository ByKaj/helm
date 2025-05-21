<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/bazarr.png" height="120" alt="Bazarr logo">
</p>

# Bazarr
*Bazarr is a companion application to Sonarr and Radarr that automatically manages and downloads subtitles for your movies and TV shows. It integrates with various subtitle providers to find and match the best subtitles for your media library.*

**Homepage:** <https://www.bazarr.media>

## Prerequisites
This application requires:
- A volume in Longhorn named `bazarr-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- The SMB credentials stored in the secret `smb-credentials` in the `default` namespace;
- The same volume mounts to SMB shares as [Sonarr](https://github.com/ByKaj/helm/tree/main/charts/sonarr) and/or [Radarr](https://github.com/ByKaj/helm/tree/main/charts/radarr).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/bazarr/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 1Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3

  # Source and target for your movies folder
  movies:
    # Mount path in the container
    mountPath: /movies
    # Source on the SMB share
    source: //SERVER/Media
    subPath: Movies

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
helm install bazarr bykaj/bazarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall bazarr
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