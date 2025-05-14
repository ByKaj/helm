<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/dsmr-reader.png" height="120" alt="DSMR-reader logo">
</p>

# DSMR-reader
*DSMR-protocol reader, telegram data storage and energy consumption visualizer. 
Can be used for reading the smart meter DSMR (Dutch Smart Meter Requirements) P1 port yourself at your home. 
You will need a cable and hardware that can run Linux software. 
**Free for non-commercial use**.*

**Homepage:** <https://github.com/dsmrreader/dsmr-reader>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  db:
    # The database username and password
    secret:
      - name: POSTGRES_USER
        value: dsmrreader
      - name: POSTGRES_PASSWORD
        value: Pl3@s3!Ch@ng3M3
    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /var/lib/postgresql/data
      readOnly: false
      name: config
      subPath: postgresql

  app:
    # Your local timezone and the operation mode
    # Ref: https://github.com/xirixiz/dsmr-reader-docker#dsmr-datalogger-related
    env:
      - name: DJANGO_TIME_ZONE
        value: Europe/Amsterdam
      - name: DSMRREADER_OPERATION_MODE
        value: api_server
    # The admin username and password
    secret:
      - name: DSMRREADER_ADMIN_USER
        value: admin
      - name: DSMRREADER_ADMIN_PASSWORD
        value: Pl3@s3!Ch@ng3M3

ingress:
  # Your domain name
  rootDomain: domain.tld
  # The subdomain of the domain (e.g. `my-app`)
  # @default -- `<app.fullname>`
  subDomainOverride: ""
  # The secret containing the wildcard certificate
  # @default -- `domain-tld-tls`
  tlsSecret: ""

# Add the persistent volumes (Longhorn) to the pod
volumes:
- name: config
  className: longhorn
  accessModes: 
  - ReadWriteOnce
  storage: 3Gi
  source: ""
```

Finally, install the chart:
```bash
helm install dsmr-reader bykaj/dsmr-reader -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall dsmr-reader
```