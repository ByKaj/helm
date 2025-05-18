<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/linkwarden.png" height="120" alt="Linkwarden logo">
</p>

# Linkwarden
*Linkwarden is a self-hosted bookmark and link management solution designed to help you organize, archive, and share web content. It allows you to categorize links into collections, add tags and notes, and create a searchable personal knowledge base of web resources that you can access from anywhere.*

**Homepage:** <https://linkwarden.app>

## Usage
This example uses S3 for storage and the local LLM Ollama for AI tagging. For more information check the [official documentation](https://docs.linkwarden.app/self-hosting/installation) on self-hosting Linkwarden.

Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  db:
    # Your local timezone and the database name
    env:
    - name: PG_TZ
      value: Europe/Amsterdam
    - name: POSTGRES_DB
      value: linkwarden

    # The database username and password
    secret:
    - name: POSTGRES_USER
      value: linkwarden
    - name: POSTGRES_PASSWORD
      value: Pl3@s3Ch@ng3M3!

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /var/lib/postgresql/data
      readOnly: false
      name: config
      subPath: postgresql

  meilisearch:
    # The Meilisearch master key
    secret:
    - name: MEILI_MASTER_KEY
      value: Pl3@s3Ch@ng3M3!

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /meili_data
      readOnly: false
      name: config
      subPath: meilisearch

  ollama:
    # Your local timezone
    env:
    - name: TZ
      value: Europe/Amsterdam

    # The volume mounts inside the container
    volumeMounts:
    - mountPath: /root/.ollama
      name: config
      subPath: ollama

  app:
    # Environment variables for your setup
    # Ref: https://docs.linkwarden.app/self-hosting/environment-variables
    env:
    - name: NEXTAUTH_URL
      value: https://linkwarden.<domain>.<tld>/api/v1/auth
    - name: MEILI_HOST
      value: http://localhost:7700
    - name: SPACES_ENDPOINT
      value: <S3_ENDPOINT_URL>
    - name: SPACES_BUCKET_NAME
      value: <S3_BUCKET_NAME>
    - name: SPACES_REGION
      value: <S3_REGION>
    - name: SPACES_FORCE_PATH_STYLE
      value: "true"
    - name: BASE_URL
      value: https://linkwarden.<domain>.<tld>
    - name: NEXT_PUBLIC_OLLAMA_ENDPOINT_URL
      value: http://localhost:11434
    - name: OLLAMA_MODEL
      value: "phi3:mini-4k"

    # Secret variables for your setup
    # Ref: https://docs.linkwarden.app/self-hosting/environment-variables
    secret:
    - name: DATABASE_URL
      value: postgresql://<DB_USER>:<DB_PASSWORD>@localhost:5432/<DB>
    - name: NEXTAUTH_SECRET
      value: Pl3@s3Ch@ng3M3!
    - name: SPACES_KEY
      value: <S3_KEY>
    - name: SPACES_SECRET
      value: <S3_SECRET>

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
  storage: 10Gi
  source: ""
```

Finally, install the chart:
```bash
helm install linkwarden bykaj/linkwarden -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall linkwarden
```