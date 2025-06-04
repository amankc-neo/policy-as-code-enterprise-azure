# Policy-as-Code CI/CD Governance (Azure Enterprise)

This repository demonstrates automated policy enforcement in a GitOps + CI/CD pipeline using:

- ✅ OPA (Open Policy Agent)
- ✅ Rego policies
- ✅ GitHub Actions
- ✅ Enterprise target: Azure AKS + GitHub pipelines

## Structure
policies/
│
├── kubernetes/ → Rego rules for K8s manifests
├── github/ → Rego rules for GitHub workflows
├── terraform/ → Rego rules for IaC validation
└── common/ → Shared policy helpers


## CI/CD Integration

On every push or PR, GitHub Actions:
- Runs Conftest
- Applies Rego policies to test-data or repo files
- Blocks the pipeline if any policy violations are found
$ conftest test test-data/sample-deployment.yaml --policy policies/
