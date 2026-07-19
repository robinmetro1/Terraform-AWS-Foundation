# Local GitOps lab (kind + ArgoCD)

The $0 half of the project: run Kubernetes and ArgoCD **locally** with
[kind](https://kind.sigs.k8s.io/) instead of paying for managed EKS. This
reuses the same GitOps pattern as the
[vcluster-gitops-platform](https://github.com/robinmetro1/vcluster-gitops-platform)
project.

## Prerequisites
- Docker
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- kubectl
- [helm](https://helm.sh/docs/intro/install/)

## Run
```bash
cd local-gitops
chmod +x bootstrap-argocd.sh
./bootstrap-argocd.sh
```

## Access ArgoCD
```bash
kubectl -n argocd port-forward svc/argocd-server 8080:443
# browse https://localhost:8080  (user: admin, password printed by the script)
```

## Tear down
```bash
kind delete cluster --name gitops-lab
```

## Optional next step
Point an ArgoCD `Application` at a Git repo of Kubernetes manifests to show a
full commit -> auto-sync loop. That single screen recording is worth a lot in
an interview.
