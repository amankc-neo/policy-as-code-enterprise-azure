# Policy-as-Code CI/CD Governance (Azure Enterprise)

This repository demonstrates automated policy enforcement in a GitOps + CI/CD pipeline using:

- ✅ OPA (Open Policy Agent)
- ✅ Rego policies
- ✅ GitHub Actions
- ✅ Enterprise target: Azure AKS + GitHub pipelines

## Structure
policy-as-code-enterprise-azure/
├── policies/
│   ├── github/
│   │   ├── deny-unapproved-actions.rego
│   │   └── block-secrets-in-workflows.rego
│   ├── kubernetes/
│   │   ├── disallow-latest-tag.rego
│   │   ├── restrict-container-registry.rego
│   │   └── enforce-labels.rego
│   ├── terraform/
│   │   ├── enforce-approved-regions.rego
│   │   └── deny-public-s3-buckets.rego
│   └── common/
│       └── helpers.rego
├── test-data/
│   ├── sample-deployment.yaml
│   ├── bad-github-workflow.yml
│   └── insecure-terraform.tf



## CI/CD Integration

On every push or PR, GitHub Actions:
- Runs Conftest
- Applies Rego policies to test-data or repo files
- Blocks the pipeline if any policy violations are found

## $ conftest test test-data/sample-deployment.yaml --policy policies/
