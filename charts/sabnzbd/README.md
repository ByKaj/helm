<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/sabnzbd.svg" height="120" alt="SABnzbd logo">
</p>

# SABnzbd
*SABnzbd is a free, open-source binary newsreader that simplifies the process of downloading from Usenet by automating the downloading, verifying, repairing, extracting, and organizing of files. It offers a web-based interface that allows users to manage their downloads from any device on their network.*

**Homepage:** <https://sabnzbd.org>

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
    - mountPath: /incomplete-downloads
      readOnly: false
      name: downloads

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
  storage: 1Gi
  source: ""
# Downloads on a SMB share
- name: downloads
  className: smb
  accessModes:
  - ReadWriteMany
  storage: 100Gi
  source: //SERVER/Downloads
```

Finally, install the chart:
```bash
helm install sabnzbd bykaj/sabnzbd -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall sabnzbd
```