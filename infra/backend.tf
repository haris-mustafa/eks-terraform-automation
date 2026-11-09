# Partial configuration: bucket / key / table are supplied at init time via
#   -backend-config=envs/<env>.backend.hcl  and  -backend-config="bucket=<name>"
# (the Makefile does this for you). Each environment gets its own state file.
terraform {
  backend "s3" {}
}
