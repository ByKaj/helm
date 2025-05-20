<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/jellyseerr.svg" height="120" alt="Jellyseerr logo">
</p>

# Jellyseerr
*Jellyseerr is a content request and management system for Plex, Jellyfin and Emby media servers that allows users to easily request new movies and TV shows. It integrates with Radarr and Sonarr to automatically add approved requests to your download queue, creating a seamless request-to-watch experience for your media server users.*

**Homepage:** <https://docs.jellyseerr.dev>

## Prerequisites
This application requires:
- A volume in Longhorn named `jellyseerr-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/jellyseerr/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 1Gi
  
  # Log level
  logLevel: info

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install jellyseerr bykaj/jellyseerr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall jellyseerr
```