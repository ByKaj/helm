<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/paperless-ngx.svg" height="120" alt="paperless logo">
</p>

# Paperless-ngx
*Paperless-ngx is a document management system that transforms your physical documents into a searchable digital archive by scanning and analyzing paper documents. It automatically extracts information like dates, correspondents, and content, allowing you to organize, search, and retrieve your documents without maintaining physical paper storage.*

**Homepage:** <https://docs.paperless-ngx.com>

## Prerequisites
This application requires:
- A volume in Longhorn named `paperless-ngx-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- A SMB share (with the root folders `consume`, `media` and `export`) where your documents are stored.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/paperless-ngx/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi

  # Source and target for your movies folder
  archive:
    # Source on the SMB share
    source: //SERVER/Archive
    # Mount paths in the container with the corresponding subpath on the share
    media:
      mountPath: /usr/src/paperless/media
      shareSubPath: media
    consume:
      mountPath: /usr/src/paperless/consume
      shareSubPath: consume
    export:
      mountPath: /usr/src/paperless/export
      shareSubPath: export

  # Database name
  databaseName: paperless

  # Database username
  databaseUsername: paperless

  # Database password
  databasePassword: Pl3@s3Ch@ng3M3!

  # Admin user credentials
  # Automatically creates a superuser with the provided username and password
  paperlessAdminUsername: admin
  paperlessAdminPassword: Pl3@s3Ch@ng3M3!

  # Paperless URL
  paperlessUrl: https://paperless.example.com

  # Customize the language that Paperless will attempt to use when parsing documents
  paperlessOcrLanguage: nld+eng

  # Install languages not installed by default
  paperlessOcrLanguages: nld

  # Filename format
  paperlessFilenameFormat: "{ created }-{ correspondent }-{ title }"

  # Secret key for encryption
  paperlessSecretKey: SecretKeyOf50+Char

  # Global API key
  paperlessApiKey: ApiKeyOf40+Char

  # Poll frequency (in minutes) of the `consume` folder
  paperlessConsumerPolling: "15"

  # When using a SSO provider: configuration
  paperlessApps: ""
  paperlessSocialAccountProviders: ""

  # When using a SSO provider: disable regular login
  paperlessDisableRegularLogin: "false"

  # When using a SSO provider: redirect login to SSO
  paperlessRedirectLoginToSso: "false"

  # When using a SSO provider: URL to redirect the user to after a logout
  paperlessLogoutRedirectUrl: "None"

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install paperless-ngx bykaj/paperless-ngx -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall paperless-ngx
```