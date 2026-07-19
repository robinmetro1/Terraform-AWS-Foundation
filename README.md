# Terraform AWS Foundation + Local GitOps

Infrastructure-as-Code portfolio project. It provisions a reusable AWS network
foundation with **Terraform** (modules, remote state, CI-driven `plan`/`apply`),
and pairs it with a **local Kubernetes + ArgoCD** GitOps lab — all within the
**AWS Free Tier ($0)**.

> Built to demonstrate declarative IaC end to end without paying for managed
> EKS. The cloud layer proves Terraform; the local layer proves GitOps.

## What it demonstrates
- **Terraform modules** (`modules/vpc`, `modules/security`) — reusable, variable-driven.
- **Remote state** in S3 with **DynamoDB state locking** (the `bootstrap/` step).
- **Environment layout** (`envs/dev`) that composes the modules.
- **CI/CD**: GitHub Actions runs `fmt` + `validate` + `plan` on every PR and
  `apply` on merge to `main`.
- **GitOps**: kind + ArgoCD locally (`local-gitops/`), same pattern as managed clusters.

## Architecture
```
                    GitHub Actions (plan on PR / apply on main)
                                   |
                                   v
   bootstrap/  --creates-->  S3 (state) + DynamoDB (lock)
                                   ^
                                   | remote backend
   envs/dev/  --uses modules-->  modules/vpc  +  modules/security
                                   |
                                   v
                    AWS: VPC + public subnets + IGW + SG   (Free Tier)

   local-gitops/  -->  kind cluster + ArgoCD (Helm)        (local, $0)
```

## Repository layout
```
.
├── bootstrap/            # one-time: S3 bucket + DynamoDB lock table (local state)
├── envs/dev/             # the dev environment (uses S3 backend + modules)
├── modules/
│   ├── vpc/              # VPC, public subnets, IGW, routing
│   └── security/         # web security group
├── local-gitops/         # kind + ArgoCD (free, no cloud)
└── .github/workflows/    # CI: fmt, validate, plan (PR), apply (main)
```

## Prerequisites
- An AWS account (Free Tier — see below)
- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- AWS CLI configured (`aws configure`) with an IAM user (not root)

## Step-by-step

### 1. Create the remote-state backend (once)
```bash
cd bootstrap
cp terraform.tfvars.example terraform.tfvars   # set a GLOBALLY-UNIQUE bucket name
terraform init
terraform apply
```
Note the outputs (bucket + lock table names).

### 2. Point the dev environment at that backend
Edit `envs/dev/backend.tf` and paste the bucket name + table from step 1.

### 3. Provision the network
```bash
cd ../envs/dev
terraform init      # migrates state to S3
terraform plan
terraform apply
```

### 4. DESTROY when done (important — see cost note)
```bash
terraform destroy         # in envs/dev
# and, only if you want to remove the backend too:
cd ../../bootstrap && terraform destroy
```

### 5. Local GitOps lab (optional, free)
See [`local-gitops/README.md`](local-gitops/README.md) — kind + ArgoCD in one script.

## Cost & safety
- This stack uses **only Free-Tier / no-cost resources**: VPC, subnets, IGW,
  route tables, and security groups are **free**; S3 and DynamoDB usage here is
  a few KB / a handful of requests → inside the Free Tier.
- **No NAT gateway, no EC2, no EKS** — those are the things that cost money, and
  they are deliberately avoided.
- Still: **run `terraform destroy` when you're done**, and set a **billing alert**
  (see AWS Free Tier notes) so nothing ever surprises you.

## CI credentials
The workflow reads `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` from GitHub repo
**Secrets** (Settings → Secrets and variables → Actions). Create a dedicated IAM
user with least-privilege permissions for this.
**Better practice:** use GitHub OIDC with an IAM role (no long-lived keys) —
a great "v2" improvement to mention in interviews.

## Résumé / CV line
> *Provisioned an AWS network foundation (VPC, subnets, security groups) with
> Terraform — reusable modules, S3+DynamoDB remote state, and a CI pipeline
> (`plan` on PR, `apply` on merge). Paired with a local kind + ArgoCD GitOps lab.*

Skills to add once this is live: **Terraform**, and reinforce **AWS**, **CI/CD**, **GitOps**.
