<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/stash.svg" height="120" alt="stash logo">
</p>

# Stash
*Stash is a self-hosted organizer and manager for your adult media collection with advanced metadata scraping capabilities. It provides powerful tagging, searching, and scene recognition features while offering a modern web interface to browse and play your content.*

**Homepage:** <https://github.com/stash/stash>

## Prerequisites
This application requires:
- A volume in Longhorn named `stash-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- The SMB credentials stored in the secret `smb-credentials` in the `default` namespace.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/stash/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 5Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3

  # Source and target for your media folder
  media:
    # Mount path in the container
    mountPath: /data
    # Source on the SMB share
    source: //SERVER/Media
    subPath: ""

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install stash bykaj/stash -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall stash
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