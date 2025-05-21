<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/authentik.svg" height="120" alt="Authentik logo">
</p>

# Authentik
*Authentik is an open-source Identity Provider (IdP) and Single Sign-On (SSO) solution built with security at its core, allowing organizations to manage authentication and authorization across applications without relying on third-party services.*

**Homepage:** <https://goauthentik.io>

## Prerequisites
This application requires:
- A volume in Longhorn named `authentik-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/authentik/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3

  # Database name
  databaseName: authentik

  # Database username
  databaseUsername: authentik

  # Database password
  databasePassword: Pl3@s3Ch@ng3M3!

  # Authentik configuration
  authentik:
    # Log level
    logLevel: info

    # Cookie domain
    cookieDomain: example.com

    # Trusted proxy CIDR's
    proxyCIDRs: "127.0.0.1/32,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"

    # Secret key used for cookie singing and unique user IDs
    secretKey: PleaseGenerateA50CharKey

    # Email configuration
    emailHost: ""
    emailPort: "587"
    emailUseTLS: "true"
    emailUseSSL: "false"
    emailFrom: "Authentik <authentik@example.com>"
    emailUsername: ""
    emailPassword: ""

  # GeoIP configuration
  # Sign up here: https://www.maxmind.com/en/geolite2/signup
  geoip:
    accountId: ""
    licenseKey: ""

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install authentik bykaj/authentik -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall authentik
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