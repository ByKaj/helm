<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/svg/readarr.svg" height="120" alt="Readarr logo">
</p>

# Readarr
*Readarr is an e-book and audiobook collection manager that automatically finds, downloads, and organizes your digital book library. It integrates with various indexers and download clients to track authors, monitor for new releases, and maintain a well-organized book collection with rich metadata.*

**Homepage:** <https://readarr.com>

## Prerequisites
This application requires:
- A volume in Longhorn named `readarr-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);
- The SMB credentials stored in the secret `smb-credentials` in the `default` namespace.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/readarr/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 5Gi

  # Source and target for your books folder
  books:
    # Mount path in the container
    mountPath: /books
    # Source on the SMB share
    source: //SERVER/Media
    subPath: Books

  # Source and target for your downloads folder
  downloads:
    # Mount path in the container
    mountPath: /downloads
    # Source on the SMB share
    source: //SERVER/Downloads
    subPath: ""

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install readarr bykaj/readarr -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall readarr
```