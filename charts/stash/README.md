<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/stash.svg" height="120" alt="stash logo">
</p>

# Stash
*Stash is a self-hosted organizer and manager for your adult media collection with advanced metadata scraping capabilities. It provides powerful tagging, searching, and scene recognition features while offering a modern web interface to browse and play your content.*

**Homepage:** <https://github.com/stash/stash>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Container mount paths:
  # Where your 'media' volume is mounted
  pathData: /data/
  # Where to store generated content (screenshots, previews, transcodes, sprites)
  pathGenerated: /generated/
  # This is where your stash's metadata lives
  pathMetadata: /metadata/
  # Any other cache content
  pathCache: /cache/

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
    storage: 5Gi
    source: ""
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
helm install stash bykaj/stash -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall stash
```