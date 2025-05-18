<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/readarr.svg" height="120" alt="Readarr logo">
</p>

# Readarr
*Readarr is an e-book and audiobook collection manager that automatically finds, downloads, and organizes your digital book library. It integrates with various indexers and download clients to track authors, monitor for new releases, and maintain a well-organized book collection with rich metadata.*

**Homepage:** <https://readarr.com>

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
    - mountPath: /books
      readOnly: false
      name: media
      subPath: Books

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
helm install readarr bykaj/readarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall readarr
```