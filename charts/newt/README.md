<p align="center">
    <img src="https://avatars.githubusercontent.com/u/183037913" height="120" alt="Newt logo">
</p>

# DSMR-reader
*Newt is a fully user space WireGuard tunnel client and TCP/UDP proxy, designed to securely expose private resources controlled by Pangolin. By using Newt, you don't need to manage complex WireGuard tunnels and NATing.*

**Homepage:** <https://github.com/fosrl/newt>

## Usage
Make a local `values.yaml` file with the following content and change the values to match your environment.
```yaml
containers:
  app:
    # The endpoint to your Pangolin server and Site ID
    env:
    - name: PANGOLIN_ENDPOINT
      value: https://pangolin.domain.tld
    - name: NEWT_ID
      value: ChangeMe

    # The secret key
    secret:
    - name: NEWT_SECRET
      value: ChangeMe
```

Finally, install the chart:
```bash
helm install newt bykaj/newt -f values.yaml
```
To uninstall the chart:
```bash
helm uninstall newt
```