<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/prowlarr.svg" height="120" alt="Prowlarr logo">
</p>

# Prowlarr
*Prowlarr is an indexer manager/proxy that integrates with various media management applications like Sonarr, Radarr, and Lidarr. It centralizes the management of indexers across all your media applications, allowing you to configure and maintain them in one place while automatically syncing the indexers to your other applications.*

**Homepage:** <https://prowlarr.com>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  app:
    # Your local timezone and the user/group ID's (default: "0")
    env:
    - name: TZ
      value: Europe/Amsterdam
    - name: PUID
      value: "0"
    - name: PGID
      value: "0"

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /config
      readOnly: false
      name: config

ingress:
  # Your domain name(s)
  domains: 
  - domain.tld
  # The subdomain of the domain (e.g. `my-app`)
  # @default -- `<app.fullname>`
  subdomainOverride: ""
  
# Add the persistent volumes
volumes:
# Config store on Longhorn
- name: config
  className: longhorn
  accessModes: 
  - ReadWriteOnce
  storage: 3Gi
  source: ""
```

Finally, install the chart:
```bash
helm install prowlarr bykaj/prowlarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall prowlarr
```