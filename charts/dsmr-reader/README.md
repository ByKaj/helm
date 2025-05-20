<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/selfhst/icons/png/dsmr-reader.png" height="120" alt="DSMR-reader logo">
</p>

# DSMR-reader
*DSMR-protocol reader, telegram data storage and energy consumption visualizer. 
Can be used for reading the smart meter DSMR (Dutch Smart Meter Requirements) P1 port yourself at your home. 
You will need a cable and hardware that can run Linux software. 
**Free for non-commercial use**.*

**Homepage:** <https://github.com/dsmrreader/dsmr-reader>

## Prerequisites
This application requires:
- A volume in Longhorn named `dsmr-reader-config`;
- A secret with a wildcard certificate in the same namespace named `example-com-tls` (change to your domainname).

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/dsmr-reader/values.yaml).
```yaml
global:
  # Local timezone
  timezone: Europe/Amsterdam

  # Storage request for the config folder
  configStorage: 3Gi
  
  # Database name
  databaseName: dsmrreader

  # Database username
  databaseUsername: dsmrreader

  # Database password
  databasePassword: dsmrreader

  # Operation mode
  # Ref: https://github.com/xirixiz/dsmr-reader-docker#dsmr-datalogger-related 
  operationMode: api_server

  # Backend admin username
  adminUsername: admin

  # Backend admin password
  adminPassword: password

ingress:
  # Your domain name(s)
  domains: 
    - example.com

  # The subdomain of the domain (e.g. `my-app`, defaults to `app.fullname`)
  subdomainOverride: ""
```

Finally, install the chart:
```bash
helm install dsmr-reader bykaj/dsmr-reader -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall dsmr-reader
```