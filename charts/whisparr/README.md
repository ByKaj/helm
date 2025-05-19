<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/whisparr.svg" height="120" alt="Whisparr logo">
</p>

# Whisparr
*Whisparr is an automated adult video content manager that monitors for new releases, downloads them automatically, and organizes your media collection. It integrates with various indexers and download clients to provide a streamlined experience for managing adult content with customizable quality profiles and metadata management.*

**Homepage:** <https://github.com/Whisparr/Whisparr>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

containers:
  app:
    # The volume mounts inside the container
    # The `name` references a volume in `volumes`
    volumeMounts:
    - mountPath: /config
      readOnly: false
      name: config
    - mountPath: /downloads
      readOnly: false
      name: downloads
    - mountPath: /data
      readOnly: false
      name: media

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
  # Downloads on a SMB share
  - name: downloads
    className: smb
    accessModes: 
    - ReadWriteMany
    storage: 100Gi
    source: //SERVER/Downloads
  # Media on a SMB share
  - name: media
    className: smb
    accessModes: 
    - ReadWriteMany
    storage: 100Gi
    source: //SERVER/Media
```

Finally, install the chart:
```bash
helm install whisparr bykaj/whisparr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall whisparr
```