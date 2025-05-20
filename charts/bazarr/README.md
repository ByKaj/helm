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
- The same volume mounts to SMB shares as [Sonarr](https://github.com/ByKaj/helm/tree/main/charts/sonarr) and [Radarr](https://github.com/ByKaj/helm/tree/main/charts/radarr).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/bazarr/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 1Gi

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