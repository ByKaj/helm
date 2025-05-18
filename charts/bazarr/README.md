<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/bazarr.png" height="120" alt="Bazarr logo">
</p>

# Bazarr
*Bazarr is a companion application to Sonarr and Radarr that automatically manages and downloads subtitles for your movies and TV shows. It integrates with various subtitle providers to find and match the best subtitles for your media library.*

**Homepage:** <https://www.bazarr.media>

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
    - mountPath: /movies
      subPath: Movies
      readOnly: false
      name: media
    - mountPath: /tv
      subPath: Series
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
helm install bazarr bykaj/bazarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall bazarr
```