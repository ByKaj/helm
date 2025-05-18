<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/paperless-ngx.svg" height="120" alt="paperless logo">
</p>

# Paperless-ngx
*Paperless-ngx is a document management system that transforms your physical documents into a searchable digital archive by scanning and analyzing paper documents. It automatically extracts information like dates, correspondents, and content, allowing you to organize, search, and retrieve your documents without maintaining physical paper storage.*

**Homepage:** <https://docs.paperless-ngx.com>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  ## PostgreSQL
  db:
    # Your local timezone and the database name
    env:
    - name: PG_TZ
      value: Europe/Amsterdam
    - name: POSTGRES_DB
      value: paperless

    # The database username and password
    secret:
    - name: POSTGRES_USER
      value: paperless
    - name: POSTGRES_PASSWORD
      value: Pl3@s3Ch@ng3M3!

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /var/lib/postgresql/data
      readOnly: false
      name: config
      subPath: postgresql

  ## Redis
  broker:
    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /data
      readOnly: false
      name: config
      subPath: redis

  ## Paperless-ngx
  app:
    # Environment variables for your setup
    # Ref: https://docs.paperless-ngx.com/configuration/
    env:
    - name: USERMAP_UID
      value: "0"
    - name: USERMAP_GID
      value: "0"
    - name: POSTGRES_DB
      value: paperless
    - name: PAPERLESS_REDIS
      value: redis://localhost:6379
    - name: PAPERLESS_DBHOST
      value: localhost
    - name: PAPERLESS_URL
      value: https://paperless.domain.tld
    - name: PAPERLESS_TIME_ZONE
      value: Europe/Amsterdam
    - name: PAPERLESS_OCR_LANGUAGE
      value: nld+eng
    - name: PAPERLESS_OCR_LANGUAGES
      value: nld
    - name: PAPERLESS_FILENAME_FORMAT
      value: "{ created }-{ correspondent }-{ title }"

    # Secret variables for your setup
    # Ref: https://docs.paperless-ngx.com/configuration/
    secret:
    - name: POSTGRES_USER
      value: paperless
    - name: POSTGRES_PASSWORD
      value: Pl3@s3Ch@ng3M3!
    - name: PAPERLESS_SECRET_KEY
      value: SuperSecretKeyOf50Chars
    - name: PAPERLESS_API_KEY
      value: ApiKeyOf40Chars

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /usr/src/paperless/data
      name: config
      subPath: paperless
    - mountPath: /usr/src/paperless/media
      readOnly: false
      name: archive
      subPath: media
    - mountPath: /usr/src/paperless/consume
      readOnly: false
      name: archive
      subPath: consume
    - mountPath: /usr/src/paperless/export
      readOnly: false
      name: archive
      subPath: export

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
# Document store on a SMB share
- name: archive
  className: smb
  accessModes: 
  - ReadWriteMany
  storage: 100Gi
  source: //SERVER/Archive
```

Finally, install the chart:
```bash
helm install paperless-ngx bykaj/paperless-ngx -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall paperless-ngx
```