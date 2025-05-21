<p align="center">
    <img src="https://raw.githubusercontent.com/DartSteven/Nutify/refs/heads/main/pic/Nutify-Logo.png" height="120" alt="nutify logo">
</p>

# Nutify
*Nutify is a comprehensive UPS monitoring system that provides real-time insights into UPS health and performance through a user-friendly web interface, detailed reports, and interactive charts.*

**Homepage:** <https://github.com/DartSteven/Nutify>

## Prerequisites
This application requires:
- A volume in Longhorn named `nutify-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/nutify/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi
  
  # Secret key used for encryption
  secretKey: SecretKeyOf32+Char

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install nutify bykaj/nutify -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall nutify
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