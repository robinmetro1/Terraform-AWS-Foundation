# Playground environment (ephemeral sandboxes)

A self-contained copy of `envs/dev` tuned for **throwaway AWS sandboxes** like the
KodeKloud AWS Cloud Playground. Two differences from `dev`:

1. **No `backend.tf`** — state stays **local**. A sandbox has nothing to persist
   and no S3 bucket to point at, so the remote-backend / bootstrap step is skipped.
2. **`us-east-1` defaults** — KodeKloud sandboxes are almost always locked to
   `us-east-1`. Defaults are baked in, so you don't edit anything.

It reuses the exact same `modules/vpc` and `modules/security` as `dev`, so the
IaC you practice here is the same code the real environment runs.

## Quickstart in a KodeKloud AWS Cloud Playground

1. Start the **AWS Cloud Playground** and copy the temporary credentials
   (access key + secret + **session token** — you need all three).

2. In the playground terminal:

   ```bash
   export AWS_ACCESS_KEY_ID=...
   export AWS_SECRET_ACCESS_KEY=...
   export AWS_SESSION_TOKEN=...

   aws sts get-caller-identity        # confirm you're in the sandbox

   git clone <your-repo-url>
   cd terraform-aws-foundation/envs/playground

   terraform init                     # local state, downloads the AWS provider
   terraform plan                     # preview — screenshot this
   terraform apply                    # builds VPC + subnets + IGW + SG
   ```

3. Verify it exists:

   ```bash
   terraform output                   # vpc_id, public_subnet_ids, security_group_id
   aws ec2 describe-vpcs --filters "Name=tag:Environment,Values=playground"
   ```
   ...or open the VPC console and **screenshot it** — the infra dies with the
   session, but the screenshot is your portfolio proof.

4. (Optional) `terraform destroy` — the sandbox auto-cleans anyway.

## Gotchas
- **Session token expires** with the sandbox. If `apply` fails on an expired
  token, restart the playground and re-export the three variables.
- **Wrong region?** If the sandbox isn't `us-east-1`, override once:
  `terraform apply -var 'region=us-west-2' -var 'availability_zones=["us-west-2a","us-west-2b"]'`
- **No IAM is created** by this stack, so sandbox IAM restrictions won't block you.

## Free / persistent alternative
To practice with **no time limit and no cloud**, run this against
[LocalStack](https://localstack.cloud) on your own machine (VPC/S3/DynamoDB are
supported) — great for drilling HCL between sandbox sessions.
