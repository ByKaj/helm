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
  
  # Source and target for your config folder
  config:
    # Mount paths in the container with the corresponding subpath on the share
    blobs:
      mountPath: /blobs
      subPath: blobs
    cache:
      mountPath: /cache
      subPath: cache
    config:
      mountPath: /root/.stash
      subPath: config
    generated:
      mountPath: /generated
      subPath: generated
    metadata:
      mountPath: /metadata
      subPath: metadata

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