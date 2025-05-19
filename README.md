# Helm
Helm charts repo for self-hosted applications.

## Prerequisites
These charts are specific for a [K3s](https://k3s.io) environment with:
- [Longhorn](https://longhorn.io), for distributed block storage;
- [Cert-Manager](https://github.com/cert-manager/cert-manager), for managing wildcard Let's Encrypt certificates;
- [Reflector](https://github.com/emberstack/kubernetes-reflector), for mirroring certificate secrets to other namespaces;
- [Traefik](https://traefik.io), as a reverse proxy for ingress routing.

The charts *should* work on [Kubernetes](https://kubernetes.io) but is not tested. For other environments download the charts and amend to your needs:
```bash
helm pull --untar bykaj/<chart-name>
```

## Usage
[Helm](https://helm.sh) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add this repo as follows:
```bash
helm repo add bykaj https://charts.bykaj.com
```

If you had already added this repo earlier, run `helm repo update` to retrieve the latest versions of the packages. You can then run `helm search repo bykaj` to see the available charts.

To install a chart:
```bash
helm install <app-name> bykaj/<chart-name>
```

For all the possible configuration overrides see the `values.yaml` file in the application chart folder. Installation example with a local `values.yaml` file and a specific namespace:
```bash
helm install --namespace <namespace> --create-namespace <app-name> bykaj/<chart-name> -f /path/to/local/values.yaml
```

To uninstall the chart:
```bash
helm uninstall <app-name>
```

To debug a chart and see the generated manifest output:
```bash
helm install --dry-run <app-name> bykaj/<chart-name>
```
