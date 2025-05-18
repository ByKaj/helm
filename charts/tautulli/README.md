<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/tautulli.svg" height="120" alt="Tautulli logo">
</p>

# Tautulli
*Tautulli is a monitoring and tracking tool that provides detailed statistics and insights about your Plex Media Server usage and activity. It offers comprehensive analytics on what's being watched, who's watching it, and when, along with notifications, history logging, and custom reports to help you better understand your media consumption.*

**Homepage:** <https://tautulli.com>

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
  storage: 1Gi
  source: ""
```

Finally, install the chart:
```bash
helm install tautulli bykaj/tautulli -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall tautulli
```