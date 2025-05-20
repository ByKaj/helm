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