<p align="center">
    <img src="https://raw.githubusercontent.com/DartSteven/Nutify/refs/heads/main/pic/Nutify-Logo.png" height="120" alt="nutify logo">
</p>

# Nutify
*Nutify is a comprehensive UPS monitoring system that provides real-time insights into UPS health and performance through a user-friendly web interface, detailed reports, and interactive charts.*

**Homepage:** <https://github.com/DartSteven/Nutify>

## Prerequisites
This application requires:
- A volume in Longhorn named `nutify-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname);

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/nutify/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi
  
  # Secret key used for encryption
  secretKey: SecretKeyOf32+Char

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install nutify bykaj/nutify -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall nutify
```