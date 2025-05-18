<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/jellyseerr.svg" height="120" alt="Jellyseerr logo">
</p>

# Jellyseerr
*Jellyseerr is a content request and management system for Plex, Jellyfin and Emby media servers that allows users to easily request new movies and TV shows. It integrates with Radarr and Sonarr to automatically add approved requests to your download queue, creating a seamless request-to-watch experience for your media server users.*

**Homepage:** <https://docs.jellyseerr.dev>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  app:
    # Your local timezone and log level
    env:
    - name: TZ
      value: Europe/Amsterdam
    - name: PORT
      value: "5055"
    - name: LOG_LEVEL
      value: info

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /app/config
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
  storage: 1Gi
  source: ""
```

Finally, install the chart:
```bash
helm install jellyseerr bykaj/jellyseerr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall jellyseerr
```