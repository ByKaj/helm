<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/huntarr.png" height="120" alt="Huntarr logo">
</p>

# Huntarr
*Huntarr is an automated media library management system that continually searches for missing content and quality upgrades across your Sonarr, Radarr, Lidarr, and Readarr libraries, essentially functioning as a compulsive librarian for your media server.*

**Homepage:** <https://huntarr.io>

## Prerequisites
This application requires:
- A volume in Longhorn named `huntarr-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
Create a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all possible configuration overrides, see the default [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/huntarr/values.yaml) in the chart.
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 1Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3

  # Domainname of your application
  domainname: example.com
```

Finally, install the chart:
```bash
helm install huntarr bykaj/huntarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall huntarr
```

## Environment and secret variables
![Static Badge](https://img.shields.io/badge/Version-%3E%3D_1.1.0-white?style=flat&labelColor=lightgray)

You can add or overwrite environment and secret variables to the containers in a pod by adding the following lines to` values.yaml`:
```yaml
containers:
  app:                              # Container reference key
    env:
      MY_ENV_VAR: "foo"
    secret:
      MY_SECRET_VAR: "bar"
```

## Domainnames and path prefixes
![Static Badge](https://img.shields.io/badge/Version-%3E%3D_1.2.0-white?style=flat&labelColor=lightgray)

By default, the chart generates a FQDN based on the chart and instance name combined with the supplied `global.domainname`. For example: `test-myapp.example.com`, where `test` is the instance name, `myapp` is the chart name, and `example.com` is the supplied domainname. When the instance name is the same as the chart name, it uses only the chart name to generate the FQDN. It then binds a wildcard certificate in an existing secret named `example-com-tls` to the ingress route.

For more fine-grained control over this process, you can use the `ingress.domains` and `service` configuration overrides. When using this method, leave `global.domainname` empty.

In the following example the application is available at `https://foo.example.com/bar`:
```yaml
global:
  domainname: ""                    # Empty the domainname in global
  
containers:
  app:                              # Container reference key
    service:
      http:                         # Service reference key
        ingress:
          pathPrefix: "/bar"        # Path prefix (optional)

ingress:
  domains:
    example.com:                    # Domainname
      subdomainOverride: "foo"      # Override the subdomain (optional)
      tlsSecretOverride: ""         # TLS secret override (optional)
```

## Storage and volume mapping
![Static Badge](https://img.shields.io/badge/Version-%3E%3D_1.1.0-white?style=flat&labelColor=lightgray)

You can add or overwrite volume mounts to the containers in a pod by adding the following lines to `values.yaml`:
```yaml
containers:
  app:                              # Container reference key
    volumeMounts:
      backups:                      # Volume reference key
        "apps/myapp": "/backup"     # Format: "[source relative path]": "<container mount path>"

volumes:
  backups:                          # Volume reference key
    className: smb
    accessModes: 
      - ReadWriteMany
    storage: 100Gi
    source: //SERVER/Backups
```