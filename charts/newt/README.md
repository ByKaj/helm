<p align="center">
    <img src="https://avatars.githubusercontent.com/u/183037913" height="120" alt="Newt logo">
</p>

# Newt
*Newt is a fully user space WireGuard tunnel client and TCP/UDP proxy, designed to securely expose private resources controlled by Pangolin. By using Newt, you don't need to manage complex WireGuard tunnels and NATing.*

**Homepage:** <https://github.com/fosrl/newt>

## Prerequisites
This application requires:
- A working installation of [Pangolin](https://fossorial.io) on a remote VPS.

## Usage
Make a `values.yaml` file with the following (minimal) content and change the values to match your environment. For all the possible configuration overrides see [values.yaml](https://github.com/ByKaj/helm/blob/main/charts/newt/values.yaml).
```yaml
global:
  # The endpoint for Pangolin
  pangolinEndpoint: https://pangolin.example.com

  # Tunnel ID and secret (shown when creating a tunnel in Pangolin)
  newtId: ""
  newtSecret: ""
```

Finally, install the chart:
```bash
helm install newt bykaj/newt -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall newt
```