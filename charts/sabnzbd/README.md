<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/sabnzbd.svg" height="120" alt="SABnzbd logo">
</p>

# SABnzbd
*SABnzbd is a free, open-source binary newsreader that simplifies the process of downloading from Usenet by automating the downloading, verifying, repairing, extracting, and organizing of files. It offers a web-based interface that allows users to manage their downloads from any device on their network.*

**Homepage:** <https://sabnzbd.org>

## Prerequisites
This application requires:
- A volume in Longhorn named `sabnzbd-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- The SMB credentials stored in the secret `smb-credentials` in the `default` namespace.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/sabnzbd/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 1Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3

  # Source and target for your downloads folder
  downloads:
    # Mount path in the container
    mountPath: /downloads
    # Source on the SMB share
    source: //SERVER/Downloads
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
helm install sabnzbd bykaj/sabnzbd -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall sabnzbd
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