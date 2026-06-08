#!/usr/bin/env bash
set -euo pipefail

# Run from repo root or anywhere; script will cd to this file's folder
cd "$(dirname "$0")"

echo "Removing .terraform and .terraform.lock.hcl if present..."
rm -rf .terraform .terraform.lock.hcl || true

echo "Running terraform init -upgrade..."
terraform init -upgrade 2>&1 | tee terraform-init.log || { echo "terraform init failed; see terraform-init.log"; exit 1; }

echo "Running terraform validate..."
terraform validate 2>&1 | tee terraform-validate.log || { echo "terraform validate failed; see terraform-validate.log"; exit 1; }

echo "Running terraform plan..."
terraform plan 2>&1 | tee terraform-plan.log || { echo "terraform plan failed; see terraform-plan.log"; exit 1; }

echo "Done. Logs: terraform-init.log, terraform-validate.log, terraform-plan.log"