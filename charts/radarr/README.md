<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/radarr.svg" height="120" alt="Radarr logo">
</p>

# Radarr
*Radarr is an automated movie collection manager that monitors for new releases, downloads them automatically, and organizes your media library. It integrates with various download clients and media servers to provide a seamless movie collection experience with customizable quality profiles and metadata management.*

**Homepage:** <https://radarr.video>

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
    - mountPath: /downloads
      readOnly: false
      name: downloads
    - mountPath: /movies
      readOnly: false
      name: media
      subPath: Movies

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
helm install radarr bykaj/radarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall radarr
```