# Helm
Helm charts repo for applications.


## Usage
[Helm](https://helm.sh) must be installed to use the charts.  Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add this repo as follows:
```bash
helm repo add bykaj https://charts.bykaj.com
```

If you had already added this repo earlier, run `helm repo update` to retrieve the latest versions of the packages.  You can then run `helm search repo bykaj` to see the available charts.

To install a chart:
```bash
helm install <chart-name> bykaj/<chart-name>
```

To uninstall the chart:
```bash
helm uninstall <chart-name>
```

To debug a chart:
```bash
helm install --dry-run <chart-name> bykaj/<chart-name>
```

## Prerequisites
These charts are specific for a [K3s](https://k3s.io) environment with:
- [Longhorn](https://longhorn.io), for distributed block storage
- [Cert-Manager](https://github.com/cert-manager/cert-manager), setup to generate wildcard Let's Encrypt certificates
- [Reflector](https://github.com/emberstack/kubernetes-reflector), to mirror certificates to other namespaces
- [Traefik](https://traefik.io), for ingress routing

The charts *should* work on [Kubernetes](https://kubernetes.io) but is not tested. For other environments download the charts and amend to your needs:
```bash
helm pull --untar bykaj/<chart-name>
```
