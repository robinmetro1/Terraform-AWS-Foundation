#!/usr/bin/env bash
# Spin up a local kind cluster and install ArgoCD via Helm — 100% free, no cloud.
# Requires: docker, kind, kubectl, helm.
set -euo pipefail

echo "==> Creating kind cluster 'gitops-lab'..."
kind create cluster --config kind-config.yaml

echo "==> Adding ArgoCD Helm repo..."
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

echo "==> Installing ArgoCD into namespace 'argocd'..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
helm install argocd argo/argo-cd -n argocd

echo "==> Waiting for the ArgoCD server to be ready..."
kubectl -n argocd rollout status deploy/argocd-server --timeout=300s

echo ""
echo "==> ArgoCD initial admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo
echo ""
echo "Open the UI with:"
echo "  kubectl -n argocd port-forward svc/argocd-server 8080:443"
echo "Then browse https://localhost:8080  (user: admin)"
echo ""
echo "Tear down when done:  kind delete cluster --name gitops-lab"
