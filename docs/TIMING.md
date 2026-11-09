# Timing methodology: manual vs Terraform

Goal: produce an honest before/after number for "environment spin-up time".

## Definition of "spin-up"
From the moment you start until `kubectl get nodes` shows all nodes `Ready`
**and** the add-ons (VPC CNI, CoreDNS, kube-proxy, AWS Load Balancer Controller)
are running.

## Manual baseline (do this in the AWS Console / CLI)
Start a stopwatch and perform every step by hand:

1. Create VPC, subnets, IGW, NAT, route tables, subnet tags
2. Create cluster IAM role, node IAM role
3. Create the EKS cluster
4. Create the OIDC provider
5. Create the managed node group
6. Install add-ons + IAM policy/role + Helm install of the LB controller
7. `aws eks update-kubeconfig` and `kubectl get nodes`

Stop the stopwatch, then log it:

```bash
scripts/log_manual_time.sh dev 74 30   # 74 min 30 sec
```

## Terraform run
```bash
scripts/time_terraform.sh dev apply
```

## Repeat and average
Do **at least 3 runs of each** (more is better) and keep the same region and
sizing. Results append to `docs/timing-results.csv`.

```bash
python3 scripts/calc_reduction.py
```

## Results
| Method    | Runs | Average spin-up |
|-----------|------|-----------------|
| Manual    | TBD  | TBD             |
| Terraform | TBD  | TBD             |
| **Reduction** | | **TBD %** |

Formula: `reduction = (manual_avg - terraform_avg) / manual_avg × 100`
