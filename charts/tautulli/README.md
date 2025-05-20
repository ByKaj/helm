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