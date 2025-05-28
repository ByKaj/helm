<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/plex.svg" height="120" alt="Plex logo">
</p>

# Plex
*Plex is a comprehensive entertainment platform that allows users to stream movies, TV shows, and music, while also offering free ad-supported content and the ability to organize and stream personal media collections from their own servers.*

**Homepage:** <https://plex.tv>

<details>
<summary><strong>Table of Contents</strong> (click to expand)</summary>

1. [Prerequisites](#prerequisites)
2. [Usage](#usage)
3. [Environment and secret variables](#environment-and-secret-variables)
4. [Domainnames and path prefixes](#domainnames-and-path-prefixes)
5. [Storage and volume mapping](#storage-and-volume-mapping)

</details>

## Prerequisites
This application requires:
- A volume in Longhorn named `plex-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- The SMB credentials stored in the secret `smb-credentials` in the `default` namespace;
- When setting up a new server: a Claim Code generated on https://plex.tv/claim (expires in 4m).

## Usage
> [!NOTE]
> By default, this chart creates a service definition for the Traefik ingress route (type: `ClusterIP`). When `loadBalancerIP` is defined, it creates an additional service specific for Plex Remote Access and DLNA services (type: `LoadBalancer`). The Plex Remote Access service is then available on `http://<loadBalancerIP>:32400/` and can be used with a port forward from your router. This URL (combined with `serverAccessUrls`) is published to Plex for server discovery.

Create a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all possible configuration overrides, see the default [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/plex/values.yaml) in the chart.
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 50Gi

  # Change to the amount of agent nodes used for storage
  configReplicas: 3

  # Source and target for your media folder
  media:
    # Mount path in the container
    mountPath: /media
    # Source on the SMB share
    source: //SERVER/Media
    subPath: ""

  # Domainname of the application
  domainname: example.com

  # When setting up a new server, supply a Claim Code generated on https://plex.tv/claim
  claimCode: ""

  # Load Balancer IP for Plex Remote Access and DLNA services (optional)
  loadBalancerIP: ""

  # Server access URLs (comma separated list; http or https)
  # When `loadBalancerIP` is defined, "http://<loadBalancerIP>:32400/" is added by default
  serverAccessUrls: ""
```

Finally, install the chart:
```bash
helm install plex bykaj/plex -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall plex
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