<p align="center">
    <img src="https://raw.githubusercontent.com/DartSteven/Nutify/refs/heads/main/pic/Nutify-Logo.png" height="120" alt="nutify logo">
</p>

# Nutify
*Nutify is a comprehensive UPS monitoring system that provides real-time insights into UPS health and performance through a user-friendly web interface, detailed reports, and interactive charts.*

**Homepage:** <https://github.com/DartSteven/Nutify>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  app:
    # Secret key for password encryption (use 32+ chars)
    secret:
    - name: SECRET_KEY
      value: Pl3@s3Ch@ng3M3!

ingress:
  # Your domain name
  rootDomain: domain.tld
  # The subdomain of the domain (e.g. `my-app`)
  # @default -- `<app.fullname>`
  subDomainOverride: ""
  # The secret containing the wildcard certificate
  # @default -- `domain-tld-tls`
  tlsSecret: ""
```

Finally, install the chart:
```bash
helm install nutify bykaj/nutify -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall nutify
```