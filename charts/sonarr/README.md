<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/sonarr.svg" height="120" alt="Sonarr logo">
</p>

# Sonarr
*Sonarr is a smart PVR (Personal Video Recorder) application that automates the downloading and organization of TV shows from various sources based on user-defined quality preferences and release schedules.*

**Homepage:** <https://sonarr.tv>

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
    - mountPath: /tv
      readOnly: false
      name: media

ingress:
  # Your domain name
  rootDomain: domain.tld
  # The subdomain of the domain (e.g. `my-app`)
  # @default -- `<app.fullname>`
  subDomainOverride: ""
  # The secret containing the wildcard certificate
  # @default -- `domain-tld-tls`
  tlsSecret: ""
  
# Add the persistent volumes (Longhorn & SMB) to the pod
volumes:
- name: config
  className: longhorn
  accessModes: 
  - ReadWriteOnce
  storage: 3Gi
  source: ""
- name: downloads
  className: smb
  accessModes:
  - ReadWriteMany
  storage: 100Gi
  source: //SERVER/Downloads
- name: media
  className: smb
  accessModes: 
  - ReadWriteMany
  storage: 100Gi
  source: //SERVER/Media
```

Finally, install the chart:
```bash
helm install sonarr bykaj/sonarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall sonarr
```