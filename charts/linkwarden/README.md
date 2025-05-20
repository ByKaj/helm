<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/linkwarden.png" height="120" alt="Linkwarden logo">
</p>

# Linkwarden
*Linkwarden is a self-hosted bookmark and link management solution designed to help you organize, archive, and share web content. It allows you to categorize links into collections, add tags and notes, and create a searchable personal knowledge base of web resources that you can access from anywhere.*

**Homepage:** <https://linkwarden.app>

## Prerequisites
This application requires:
- A volume in Longhorn named `linkwarden-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
This example uses S3 for storage and the local LLM Ollama for AI tagging. For more information check the [official documentation](https://docs.linkwarden.app/self-hosting/installation) on self-hosting Linkwarden.

Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/linkwarden/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 10Gi
  
  # Database name
  databaseName: linkwarden

  # Database username
  databaseUsername: linkwarden

  # Database password
  databasePassword: Pl3@s3Ch@ng3M3!

  # Master key for Meilisearch
  meiliMasterKey: SecretKeyOf40+Chars

  # Base URL for Linkwarden
  linkwardenUrl: https://linkwarden.example.com

  # Secret key for encryption
  linkwardenSecret: SecretKeyOf64+Chars

  # S3 configuration for storage
  linkwardenS3Endpoint: https://s3.amazonaws.com
  linkwardenS3BucketName: my-linkwarden-bucket
  linkwardenS3Region: eu-central-1
  linkwardenS3AccountKey: ""
  linkwardenS3SecretKey: ""

  # Ollama model for AI tagging
  # Ref: https://docs.linkwarden.app/self-hosting/ai-worker
  ollamaModel: "phi3:mini-4k"

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install linkwarden bykaj/linkwarden -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall linkwarden
```